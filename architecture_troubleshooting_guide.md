# Flutter Riverpod Architecture & Troubleshooting Guide

This document defines the architectural patterns, data flow conventions, and code-generation troubleshooting procedures for this project.

---

## 1. Architecture Overview

The application follows a **layered, feature-first architecture** utilizing **Riverpod Generator** for state management and **Dio** for HTTP networking.

```
       ┌────────────────────────┐
       │   UI Layer (Widgets)   │
       └───────────┬────────────┘
                   │ ref.watch() / ref.read()
                   ▼
       ┌────────────────────────┐
       │  Controller Layer      │  (@riverpod AsyncNotifier)
       └───────────┬────────────┘
                   │ ref.read()
                   ▼
       ┌────────────────────────┐
       │   Repository Layer     │  (@riverpod functional provider)
       └───────────┬────────────┘
                   │ HTTP Requests
                   ▼
       ┌────────────────────────┐
       │   Network / API (Dio)  │
       └────────────────────────┘
```

---

## 2. Layer Implementation Standards

### A. Repository Layer (Data Fetching)
Repositories execute HTTP requests and map JSON to Domain models. Expose stateless repositories using **functional providers**.

```dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../domain/customer.dart';

part 'customer_repository.g.dart';

class CustomerRepository {
  CustomerRepository(this._dio);
  final Dio _dio;

  Future<List<Customer>> searchCustomers({required String searchTerm}) async {
    final response = await _dio.get(
      '/organizations/members/search',
      queryParameters: {'searchTerm': searchTerm},
    );
    final list = (response.data as List<dynamic>);
    return list.map((e) => Customer.fromJson(e)).toList();
  }
}

@riverpod
CustomerRepository customerRepository(Ref ref) {
  return CustomerRepository(ref.watch(dioProvider));
}
```

---

### B. Controller Layer (State Management)
Controllers handle business logic, store UI state, and interface with repositories using an **`AsyncNotifier` class**.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/customer.dart';
import 'customer_repository.dart';

part 'customer_controller.g.dart';

@riverpod
class CustomerSearchController extends _$CustomerSearchController {
  @override
  FutureOr<List<Customer>> build() async {
    return [];
  }

  Future<void> search(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(customerRepositoryProvider);
      return await repository.searchCustomers(searchTerm: searchTerm);
    });
  }
}
```

---

### C. UI Layer (Presentation)
Widgets consume state using `ref.watch` and handle user actions using `ref.read`.

```dart
class CustomerSearchPage extends ConsumerWidget {
  const CustomerSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerSearchControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search Customers')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              ref.read(customerSearchControllerProvider.notifier).search(value);
            },
          ),
          Expanded(
            child: customerState.when(
              data: (customers) => ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(customers[index].name),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 3. Troubleshooting Guide

### Issue 1: `build_runner` Hangs Indefinitely
If running `dart run build_runner` freezes without throwing errors:

1. **Kill zombie Dart processes:**
   * **Windows:** `taskkill /f /im dart.exe`
   * **Mac / Linux:** `killall dart`

2. **Clean build cache:**
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Force a single build (prints hidden errors):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

### Issue 2: Missing `.g.dart` Generation
* Ensure your `pubspec.yaml` separates runtime dependencies from generator packages:

```yaml
dependencies:
  flutter_riverpod: ^2.6.0
  riverpod_annotation: ^2.6.0
  dio: ^5.7.0

dev_dependencies:
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.2
```

* Verify that your file includes the exact `part` line corresponding to the file name:
  ```dart
  // If file is named customer_repository.dart
  part 'customer_repository.g.dart';
  ```

---

### Issue 3: Invalid Annotation Target
* **Cause:** Annotating a standard class with `@riverpod` without extending `_$ClassName` or implementing a `build()` method.
* **Fix:** Use a **functional provider** (`@riverpod ReturnType name(Ref ref)`) for plain classes/repositories, and reserve **class-based notifiers** (`@riverpod class Name extends _$Name`) for stateful controllers.