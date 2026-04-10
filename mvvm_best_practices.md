# MVVM Best Practices Guide with Riverpod & Flutter

## Table of Contents
- [Core MVVM Principles](#core-mvvm-principles)
- [Project Structure](#project-structure)
- [Dependency Injection with Riverpod](#dependency-injection-with-riverpod)
- [ViewModel Best Practices](#viewmodel-best-practices)
- [Model Layer Guidelines](#model-layer-guidelines)
- [View Layer Patterns](#view-layer-patterns)
- [Testing Strategies](#testing-strategies)
- [Common Anti-Patterns](#common-anti-patterns)
- [Performance Considerations](#performance-considerations)

## Core MVVM Principles

### 1. **Separation of Concerns**
```dart
// ✅ Good: Clear separation
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  // Only UI logic and state management
}

class FormRepository {
  // Only data access logic
}

class DynamicFormModel {
  // Only data representation
}
```

### 2. **Dependency Direction**
```
View → ViewModel → Repository/Services → Models
```
- Views depend on ViewModels
- ViewModels depend on Repositories/Services  
- Repositories depend on Models
- **NEVER reverse these dependencies**

### 3. **Interface Segregation**
```dart
// ✅ Use interfaces for testability
abstract class IStorageHelper {
  Future<void> saveForm(DynamicFormModel form);
  Future<DynamicFormModel?> loadForm();
}

class StorageHelper implements IStorageHelper { /* ... */ }
```

## Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── constants/
│   ├── errors/
│   └── network/
├── shared/                        # Shared components
│   ├── interfaces/               # Abstract classes
│   ├── helpers/                  # Service classes
│   ├── utils/                    # Static utilities
│   ├── widgets/                  # Reusable UI
│   └── services/                 # App-wide services
├── features/                     # Feature modules
│   └── [feature_name]/
│       ├── data/                 # Models, repositories
│       ├── domain/               # Business logic
│       └── presentation/         # Views, ViewModels
└── providers/                    # Riverpod providers
```

## Dependency Injection with Riverpod

### 1. **Provider Hierarchy**
```dart
// Base services (lowest level)
final storageHelperProvider = Provider<IStorageHelper>((ref) => StorageHelper());

// Business logic (middle level)  
final formRepositoryProvider = Provider<IFormRepository>((ref) {
  return FormRepository(storageHelper: ref.read(storageHelperProvider));
});

// ViewModels (highest level)
final formBuilderViewModelProvider = StateNotifierProvider<FormBuilderViewModel, FormBuilderViewState>((ref) {
  return FormBuilderViewModel(
    formRepo: ref.read(formRepositoryProvider),
    storageHelper: ref.read(storageHelperProvider),
  );
});
```

### 2. **Provider Organization**
```dart
// ✅ Good: Separate providers by domain
// lib/providers/storage_provider.dart
final storageHelperProvider = Provider<IStorageHelper>((ref) => StorageHelper());

// lib/providers/repository_provider.dart  
final formRepositoryProvider = Provider<IFormRepository>((ref) => FormRepository(
  storageHelper: ref.read(storageHelperProvider),
));

// lib/providers/viewmodel_provider.dart
final formBuilderViewModelProvider = StateNotifierProvider<FormBuilderViewModel, FormBuilderViewState>((ref) {
  return FormBuilderViewModel(
    formRepo: ref.read(formRepositoryProvider),
    storageHelper: ref.read(storageHelperProvider),
  );
});
```

## ViewModel Best Practices

### 1. **State Management**
```dart
// ✅ Good: Immutable state
class FormBuilderViewState {
  final List<DynamicFormModel> forms;
  final bool isLoading;
  final String? error;
  
  const FormBuilderViewState({
    this.forms = const [],
    this.isLoading = false,
    this.error,
  });
  
  FormBuilderViewState copyWith({
    List<DynamicFormModel>? forms,
    bool? isLoading, 
    String? error,
  }) {
    return FormBuilderViewState(
      forms: forms ?? this.forms,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
```

### 2. **Error Handling**
```dart
// ✅ Good: Proper error handling in ViewModel
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  Future<void> addFormField(FormFieldModel field) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      // Business logic
      final updatedForms = await _repository.addField(field);
      
      state = state.copyWith(
        forms: updatedForms,
        isLoading: false,
      );
    } on StorageException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to save form: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }
}
```

### 3. **Async Operations**
```dart
// ✅ Good: Proper async handling
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  FormBuilderViewModel({required IFormRepository repository}) 
    : _repository = repository,
      super(const FormBuilderViewState()) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final forms = await _repository.loadForms();
      state = state.copyWith(forms: forms, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
```

## Model Layer Guidelines

### 1. **Data Models**
```dart
// ✅ Good: Pure data models with JSON serialization
class DynamicFormModel {
  final String? id;
  final String? name;
  final int? version;
  final List<FormPageModel>? pages;
  
  const DynamicFormModel({
    this.id,
    this.name,
    this.version,
    this.pages,
  });
  
  // JSON serialization
  factory DynamicFormModel.fromJson(Map<String, dynamic> json) { /* ... */ }
  Map<String, dynamic> toJson() { /* ... */ }
  
  // copyWith for immutability
  DynamicFormModel copyWith({ /* ... */ }) { /* ... */ }
}
```

### 2. **Repository Pattern**
```dart
// ✅ Good: Repository abstracts data sources
abstract class IFormRepository {
  Future<List<DynamicFormModel>> getForms();
  Future<void> saveForm(DynamicFormModel form);
  Future<void> deleteForm(String id);
}

class FormRepository implements IFormRepository {
  final IStorageHelper _storageHelper;
  final IApiService _apiService;
  
  FormRepository({
    required IStorageHelper storageHelper,
    required IApiService apiService,
  }) : _storageHelper = storageHelper,
       _apiService = apiService;
       
  @override
  Future<List<DynamicFormModel>> getForms() async {
    // Try local storage first, fallback to API
    try {
      final localForms = await _storageHelper.loadForms();
      if (localForms.isNotEmpty) return localForms;
      
      final remoteForms = await _apiService.getForms();
      await _storageHelper.saveForms(remoteForms);
      return remoteForms;
    } catch (e) {
      throw RepositoryException('Failed to load forms: $e');
    }
  }
}
```

## View Layer Patterns

### 1. **Consumer Widgets**
```dart
// ✅ Good: Use Consumer for reactive UI
class FormBuilderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formBuilderViewModelProvider);
    final viewModel = ref.read(formBuilderViewModelProvider.notifier);
    
    if (state.isLoading) {
      return const LoadingWidget();
    }
    
    if (state.error != null) {
      return ErrorWidget(message: state.error!);
    }
    
    return FormBuilderView(
      forms: state.forms,
      onAddField: viewModel.addFormField,
      onRemoveField: viewModel.removeField,
    );
  }
}
```

### 2. **Avoid Business Logic in Views**
```dart
// ❌ Bad: Business logic in view
class FormBuilderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ❌ Don't put business logic here
        if (form.pages.isNotEmpty && form.pages.first.fields.length < 10) {
          // Complex validation logic...
        }
      },
      child: Text('Add Field'),
    );
  }
}

// ✅ Good: Delegate to ViewModel
class FormBuilderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(formBuilderViewModelProvider.notifier);
    
    return ElevatedButton(
      onPressed: () => viewModel.addFormField(newField),
      child: Text('Add Field'),
    );
  }
}
```

## Testing Strategies

### 1. **ViewModel Testing**
```dart
void main() {
  group('FormBuilderViewModel', () {
    late MockFormRepository mockRepository;
    late MockStorageHelper mockStorage;
    late FormBuilderViewModel viewModel;
    
    setUp(() {
      mockRepository = MockFormRepository();
      mockStorage = MockStorageHelper();
      viewModel = FormBuilderViewModel(
        formRepo: mockRepository,
        storageHelper: mockStorage,
      );
    });
    
    test('should load forms on initialization', () async {
      // Arrange
      final testForms = [DynamicFormModel(name: 'Test Form')];
      when(() => mockStorage.loadForm()).thenAnswer((_) async => testForms.first);
      
      // Act
      await viewModel.loadStoredForms();
      
      // Assert
      expect(viewModel.state.forms, equals(testForms));
      expect(viewModel.state.isLoading, false);
    });
  });
}
```

### 2. **Provider Override for Testing**
```dart
testWidgets('FormBuilderPage should display forms', (tester) async {
  final mockViewModel = MockFormBuilderViewModel();
  final testState = FormBuilderViewState(
    forms: [DynamicFormModel(name: 'Test Form')],
  );
  
  when(() => mockViewModel.state).thenReturn(testState);
  
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        formBuilderViewModelProvider.overrideWith((ref) => mockViewModel),
      ],
      child: MaterialApp(home: FormBuilderPage()),
    ),
  );
  
  expect(find.text('Test Form'), findsOneWidget);
});
```

## Common Anti-Patterns

### ❌ **Anti-Pattern 1: ViewModels Depending on UI**
```dart
// ❌ Bad: ViewModel knows about BuildContext
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  void showDialog(BuildContext context) { // ❌ Never do this
    showDialog(context: context, builder: (_) => AlertDialog());
  }
}

// ✅ Good: Use callbacks or events
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  void validateForm() {
    if (!isValid) {
      state = state.copyWith(error: 'Form validation failed');
    }
  }
}
```

### ❌ **Anti-Pattern 2: Direct SharedPreferences in ViewModel**
```dart
// ❌ Bad: Direct dependency on SharedPreferences
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  Future<void> saveForm() async {
    final prefs = await SharedPreferences.getInstance(); // ❌ Hard to test
    await prefs.setString('form', jsonEncode(form));
  }
}

// ✅ Good: Inject storage abstraction
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  final IStorageHelper _storage;
  
  Future<void> saveForm() async {
    await _storage.saveForm(form); // ✅ Testable
  }
}
```

### ❌ **Anti-Pattern 3: Massive ViewModels**
```dart
// ❌ Bad: Too many responsibilities
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  void addField() { }
  void removeField() { }
  void validateForm() { }
  void exportToPdf() { }      // ❌ Should be separate service
  void sendEmail() { }        // ❌ Should be separate service
  void uploadToCloud() { }    // ❌ Should be separate service
}

// ✅ Good: Single responsibility
class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  final IExportService _exportService;
  final IEmailService _emailService;
  
  void addField() { }
  void removeField() { }
  
  void exportForm() => _exportService.exportToPdf(state.forms.first);
}
```

## Performance Considerations

### 1. **Provider Granularity**
```dart
// ❌ Bad: Single large provider
final appStateProvider = StateNotifierProvider<AppViewModel, AppState>((ref) {
  return AppViewModel(); // Contains forms, user, settings, etc.
});

// ✅ Good: Separate providers by domain
final formBuilderProvider = StateNotifierProvider<FormBuilderViewModel, FormBuilderViewState>((ref) => FormBuilderViewModel());
final userProvider = StateNotifierProvider<UserViewModel, UserState>((ref) => UserViewModel());
final settingsProvider = StateNotifierProvider<SettingsViewModel, SettingsState>((ref) => SettingsViewModel());
```

### 2. **Selective Watching**
```dart
// ❌ Bad: Watching entire state
class FormBuilderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(formBuilderViewModelProvider); // Rebuilds on any change
    return Column(children: [
      if (state.isLoading) LoadingWidget(),
      // ...
    ]);
  }
}

// ✅ Good: Watch specific parts
class FormBuilderPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(formBuilderViewModelProvider.select((state) => state.isLoading));
    final forms = ref.watch(formBuilderViewModelProvider.select((state) => state.forms));
    
    return Column(children: [
      if (isLoading) LoadingWidget(),
      FormsList(forms: forms),
    ]);
  }
}
```

---

## Quick Reference Checklist

### ✅ MVVM Best Practices Checklist

**Architecture:**
- [ ] Clear separation: View → ViewModel → Repository → Model
- [ ] ViewModels contain only UI logic and state management  
- [ ] Models are pure data classes with JSON serialization
- [ ] Repositories abstract data access

**Riverpod Integration:**
- [ ] Use providers for dependency injection
- [ ] Separate providers by domain/feature
- [ ] Override providers in tests
- [ ] Use selective watching to optimize rebuilds

**Code Quality:**
- [ ] Use interfaces for testable services
- [ ] Implement proper error handling
- [ ] Follow async/await best practices
- [ ] Keep ViewModels focused and small

**Testing:**
- [ ] Unit test ViewModels with mocked dependencies
- [ ] Widget test Views in isolation
- [ ] Use provider overrides for test setup
- [ ] Test error states and edge cases

---

*Save this as `docs/mvvm_best_practices.md` in your project root for easy reference!*