# Frontend Architecture - VenueFlow

This document describes how the VenueFlow frontend is structured, how data flows, and how features should be implemented.

---

## 1. Architectural Style

We use a **feature-first + clean layering** approach.

Each feature is vertically sliced into:

- **presentation**: UI widgets/screens
- **application**: state + orchestration (Riverpod Notifiers)
- **domain**: business entities + repository contracts
- **data**: API DTOs, datasource, repository implementations

This gives:
- better scalability
- easier testability
- clear ownership boundaries

---

## 2. Layer Responsibilities

## Presentation Layer
Location: `features/<feature>/presentation`

Contains:
- Screens
- Form/dialog widgets
- Stateless/Stateful UI logic

Must **not**:
- Call Dio directly
- Parse raw JSON
- Contain business rules

Depends on:
- Application layer providers only

---

## Application Layer
Location: `features/<feature>/application`

Contains:
- Riverpod providers/notifiers (`Notifier`, `AsyncNotifier`)
- UI state models (`XState`)
- User intent handlers (`load`, `create`, `update`, `delete`)

Responsibilities:
- Trigger repository calls
- Manage loading/error/data states
- Expose state to presentation

---

## Domain Layer
Location: `features/<feature>/domain`

Contains:
- Core entities (`CustomerEntity`, etc.)
- Repository abstractions/interfaces

No Flutter/Dio dependencies.

---

## Data Layer
Location: `features/<feature>/data`

Contains:
- DTOs (`fromJson`, `toEntity`)
- API data sources (HTTP calls through shared `ApiClient`)
- Repository implementations

Responsibilities:
- Convert transport data to domain entities
- Hide backend payload shape from upper layers

---

## 3. Shared Core Modules

## `core/network`
- `dio_provider.dart`: configured Dio instance
- interceptor adds JWT from storage
- debug logging for request/response/error

## `core/network/api_client.dart`
- Wraps raw Dio operations
- Standardized error mapping
- Returns typed `Result<T>` objects

## `core/storage`
- `token_storage.dart` for secure token read/write/clear

## `core/error`
- `Failure` model for app-level errors

## `core/result`
- `Result<T>` union (`Success` / `FailureResult`)

---

## 4. Routing and App Shell

## Router
- Implemented with `go_router`
- Public route: `/login`
- Protected routes: `/dashboard`, `/customers`, etc.
- Redirect logic based on session state

## Shell Layout
- Shared scaffold for authenticated pages
- Sidebar/rail/drawer responsive behavior
- Page content injected as child

---

## 5. Authentication & Session

Session is the single source of truth.

Flow:
1. App startup checks stored token
2. If token exists, call `/auth/me`
3. Populate authenticated session state
4. Router allows protected navigation
5. Logout clears token and resets session

---

## 6. Multi-Tenant Considerations

Backend enforces tenancy; frontend respects it.

Rules:
- Frontend must not trust/send arbitrary `TenantId` in normal CRUD payloads
- Tenant comes from backend JWT claim
- Use `/auth/me` to display active tenant context
- If tenant switching is added later, it should be explicit and role-restricted

---

## 7. Feature Implementation Template

For a new feature (example: `venues`), create:

```text
features/venues/
  domain/
    venue_entity.dart
    venues_repository.dart
  data/
    venue_dto.dart
    venues_api_datasource.dart
    venues_repository_impl.dart
  application/
    venues_controller.dart
  presentation/
    venues_screen.dart
    venue_form_dialog.dart
```

Implementation order:
1. domain entity + repository contract
2. data DTO + datasource + repository impl
3. application controller
4. presentation screen/dialog
5. router registration

---

## 8. State Management Conventions (Riverpod)

- Use `Provider` for dependencies (api client, repos)
- Use `NotifierProvider` for mutable screen states
- Use `AsyncNotifierProvider` for async bootstrap/session states

Controller methods should follow:
- set loading state
- call repository
- map success/failure
- refresh list where needed

---

## 9. Error Handling Strategy

- All API exceptions become `Failure`
- UI displays human-readable error messages
- Avoid leaking raw stack traces to users
- Use consistent fallback messages if API payload shape differs

---

## 10. API Communication Pattern

Presentation → Application Controller → Repository Interface → Repository Impl → Datasource → ApiClient(Dio) → Backend API

No layer skipping allowed.

---

## 11. Theming System

Theme files under `app/theme/` map `DESIGN.md` tokens:

- `app_colors.dart`
- `app_text_theme.dart`
- `app_spacing.dart`
- `app_radius.dart`
- `app_theme.dart`

Use tokenized values, not arbitrary hardcoded styles in feature widgets.

---

## 12. Testing Strategy (Recommended)

## Unit tests
- DTO mapping
- repository mapping
- controller state transitions

## Widget tests
- loading/error/data render states
- form validation

## Integration tests
- login + `/auth/me`
- customers CRUD happy path
- tenant-isolated behavior verification

---

## 13. Non-Goals (for now)

- Offline-first sync
- Complex caching strategy
- Micro-frontend modularization
- Full localization system

These can be introduced later as needed.

---

## 14. Definition of Done (per feature)

- follows folder/layer conventions
- no direct Dio in presentation/application
- handles loading/error/empty/data UI states
- wired into router and shell
- basic tests added
- docs updated if contract/flow changed