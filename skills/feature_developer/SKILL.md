# Skill: Feature Developer for Dhira HRMS

A standardized, high-performance workflow for developing or updating features in the Dhira HRMS project. This skill ensures architectural consistency across the Clean Architecture + BLoC + MVVM stack.

## Context & Standards

### **Clean Architecture Layers**
1.  **Domain**: Entities, Repository Interfaces, UseCases. (No outer dependencies).
2.  **Data**: Repository Implementations, Remote/Local Data Sources, Models (JSON-ready).
3.  **Presentation**: BLoC/Cubit, UI Pages, Widgets.

### **Core Stack**
- **State Management**: `flutter_bloc`.
- **Network Client**: Modular `DioClient` (in `lib/core/network`).
- **Dependency Injection**: `Get` lazyPut (in `lib/core/di`).
- **Routing**: `GoRouter`.
- **Exception Handling**: Standardized mapping from `Exception` (Data) to `Failure` (Domain) in `lib/core/error`.

---

## Workflow for New Features

### **1. Domain Setup**
- **Entities**: Define immutable `Equatable` classes.
- **Repository Interface**: Define an abstract class in `domain/repositories/`.
- **UseCases**: (Optional) Define individual classes for each specific business action.

### **2. Data Implementation**
- **Models**: Extend/Map from entities with `fromJson` / `toJson`. Use `Freezed` for boilerplate reduction.
- **Remote Data Source**: Implement the API call logic using `DioClient`. **Never catch `DioException` here**; let `DioClient` map them to core exceptions.
- **Repository Implementation**: Implement the domain interface. **Catch `Exception` types (Server, Network, Unauthorized) and map them to `Failure` objects.**

### **3. Presentation Implementation**
- **BLoC/Cubit**: Define States and Events. Use functional operators to process repository calls.
- **UI Components**: Build premium, responsive widgets.
    - **Aesthetics**: Use HSL colors from `AppColors`. Avoid basic hex codes.
    - **Assets**: Use `AppAssets` for images/icons.
    - **Dialogs/Toasts**: Use `AppDialogs` and `ToastUtils` instead of generic SnackBars.

---

## DioClient & Network Guidelines

### **Standard Request Flow**
```dart
// RemoteDataSource Example
final response = await dioClient.get("api/resource/YourEndpoint");
// models from json...
```

### **Session awareness**
- `DioClient` handles `401 Unauthorized` automatically via `AuthInterceptor` and `SessionManager`. 
- Repositories should simply catch `UnauthorizedException` and return `UnauthorizedFailure`.

---

## Prompts for Feature Expansion

Use these templates when asking an agent to expand a feature:

> "Add the `fetchDetails` capability to the `MyTask` feature. Follow the project's Clean Architecture standards:
> 1. Update the `MyTaskRepository` interface.
> 2. Update `MyTaskRemoteDataSource` (use the modular `DioClient`).
> 3. Map `ServerException` to `ServerFailure` in the repository impl.
> 4. Update the `MyTaskBloc` to handle the new `FetchDetails` event.
> 5. Use `AppColors` for the new UI elements."

---

## Code Generation Commands

Ensure you run these after modifying models or entities:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```
