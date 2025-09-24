# GitHub Copilot Instructions for Optimizely Commerce Flutter SDK

You are an expert in Flutter and Dart development. You are working with an enterprise-grade Flutter mobile commerce SDK that follows Clean Architecture principles and integrates with Optimizely Configured Commerce APIs. Your goal is to build
beautiful, performant, and maintainable applications following modern best
practices.

## 🏗️ Project Context

### Architecture Overview

- **Clean Architecture**: Separated into Presentation, Domain, and Data layers
- **State Management**: BLoC/Cubit pattern using flutter_bloc
- **Dependency Injection**: GetIt service locator pattern
- **API Integration**: Custom Dart SDK for Optimizely Commerce API
- **Testing**: Comprehensive unit, widget, and integration tests

### Key Technologies

- Flutter 3.27.0+
- BLoC/Cubit for state management
- GetIt for dependency injection
- Optimizely Commerce API (custom Dart SDK)
- Multiple payment providers (TokenEx, Spreedly, 3DS)
- Mobile CMS for dynamic content

## 📁 Project Structure Understanding

```text
lib/
├── features/
│   ├── domain/              # Business logic layer
│   │   ├── entity/          # Domain entities
│   │   ├── service/         # Service interfaces
│   │   └── usecases/        # Business use cases
│   └── presentation/        # UI layer
│       ├── bloc/            # BLoC state management
│       ├── cubit/           # Cubit state management
│       └── screens/         # UI screens and widgets
├── core/                    # Shared utilities
│   ├── injection/           # Dependency injection setup
│   ├── constants/           # App constants
│   └── config/              # Configuration files
└── services/                # Platform services
```

## 🎯 Code Generation Guidelines

### When Creating BLoCs/Cubits

**Always use this pattern:**

```dart
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureUseCase _featureUseCase;

  FeatureBloc({required FeatureUseCase featureUseCase})
      : _featureUseCase = featureUseCase,
        super(FeatureInitial()) {
    on<LoadFeatureEvent>(_onLoadFeatureEvent);
  }

  Future<void> _onLoadFeatureEvent(
    LoadFeatureEvent event,
    Emitter<FeatureState> emit
  ) async {
    emit(FeatureLoading());

    final result = await _featureUseCase.executeOperation();

    switch (result) {
      case Success(value: final data):
        emit(FeatureLoaded(data));
      case Failure(errorResponse: final error):
        emit(FeatureError(error.message));
    }
  }
}
```

### When Creating Use Cases

**Always extend BaseUseCase:**

```dart
class FeatureUseCase extends BaseUseCase {
  FeatureUseCase() : super();

  Future<Result<DataType, ErrorResponse>> executeOperation() async {
    final result = await commerceAPIServiceProvider
        .getServiceName()
        .performOperation();

    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final error):
        return Failure(error);
    }
  }
}
```

### Dependency Injection Registration

**Always register new components in injection_container.dart:**

```dart
// BLoCs/Cubits as factories
sl.registerFactory(() => FeatureBloc(featureUseCase: sl()));

// Use cases as factories
sl.registerFactory(() => FeatureUseCase());

// Services as singletons or factories based on need
sl.registerLazySingleton<IServiceInterface>(() => ServiceImplementation());
```

## 🚫 Critical Don'ts

### Architecture Violations to Avoid

- Don't put business logic in widgets or BLoCs
- Don't make UI components call APIs directly
- Don't create tight coupling between layers
- Don't use singleton BLoCs unless absolutely necessary

## 🔄 State Management Patterns

### State Naming Convention

```dart
abstract class FeatureState extends Equatable {}
class FeatureInitial extends FeatureState {}
class FeatureLoading extends FeatureState {}
class FeatureLoaded extends FeatureState {
  final DataType data;
  FeatureLoaded(this.data);
}
class FeatureError extends FeatureState {
  final String message;
  FeatureError(this.message);
}
```

### Event Naming Convention

```dart
abstract class FeatureEvent extends Equatable {}
class LoadFeatureEvent extends FeatureEvent {}
class UpdateFeatureEvent extends FeatureEvent {
  final String parameter;
  UpdateFeatureEvent(this.parameter);
}
```

## 🔌 API Integration Patterns

### Service Usage

```dart
// Always use dependency injection
final result = await commerceAPIServiceProvider
    .getServiceName()
    .methodName(parameters);

// Handle results with switch pattern
switch (result) {
  case Success(value: final data):
    handleSuccess(data);
  case Failure(errorResponse: final error):
    handleError(error);
}
```

### Error Handling

```dart
try {
  final result = await operation();
  return Success(result);
} catch (e) {
  return Failure(ErrorResponse(message: e.toString()));
}
```

## 🧪 Testing Requirements

### Always Include Tests

- Create BLoC tests using `bloc_test`
- Mock all external dependencies
- Test all state transitions including error scenarios
- Place tests in corresponding test directories

### Test Structure Example

```dart
blocTest<FeatureBloc, FeatureState>(
  'emits [FeatureLoading, FeatureLoaded] when operation succeeds',
  build: () => FeatureBloc(featureUseCase: mockUseCase),
  act: (bloc) => bloc.add(LoadFeatureEvent()),
  expect: () => [FeatureLoading(), FeatureLoaded(expectedData)],
);
```

## 📱 UI Development Guidelines

### Widget Composition

- Use BlocBuilder/BlocListener for state management
- Prefer composition over inheritance
- Create reusable widget components
- Follow responsive design patterns

### Navigation

```dart
// Use AppRoute enum for navigation
AppRoute.shop.navigate(context);
AppRoute.productDetails.navigate(context, pathParameters: {'productId': productId});

// For navigation with parameters
AppRoute.orderDetails.navigate(
  context,
  pathParameters: {'orderNumber': orderNumber},
  queryParameters: {'tab': 'details'},
);

// For back stack navigation
AppRoute.checkout.navigateBackStack(context);
```

## 🎨 Development Approach

### Core SDK Development

```dart
// Modify core files directly as needed for SDK features
class ProductService implements IProductService {
  @override
  Future<Result<Product, ErrorResponse>> getProduct(String productId) async {
    // Direct implementation in core SDK
  }
}
```

### Extension Pattern (For Backward Compatibility)

```dart
// Use extensions when adding optional features
extension ProductExtensions on Product {
  bool get isCustomCategory => categoryId == 'custom-category-id';
  String get customDisplayName => customProperties?['displayName'] ?? name ?? '';
}
```

## 🔧 Common Patterns to Follow

### Package Management

- If a new feature requires an external package, the AI will identify the most
  suitable and stable package from pub.dev.
- To add a regular dependency, it will execute `flutter pub add <package_name>`.
- To add a development dependency, it will execute `flutter pub add dev:<package_name>`.

### Dart Best Practices

- Follow the official Effective Dart guidelines.
- Define related classes within the same library file. For large libraries,
  export smaller, private libraries from a single top-level library.
- Group related libraries in the same folder.
- Add documentation comments to all public APIs, including classes,
  constructors, methods, and top-level functions.
- Write clear comments for complex or non-obvious code. Avoid over-commenting.
- Add trailing comments.
- Ensure proper use of `async`/`await` for asynchronous operations with robust
  error handling.
- Use pattern matching features where they simplify the code.

### Loading States

```dart
emit(FeatureLoading());

final response = await commerceAPIServiceProvider
    .getCartService()
    .clearCart();

switch (response) {
  case Success(value: final data):
    emit(FeatureLoaded(data));
    return Success(data);
  case Failure(errorResponse: final errorResponse):
    emit(FeatureError(errorResponse.message));
    return Failure(errorResponse);
}
```

### Service Access

```dart
final service = sl<IServiceInterface>();
```

### Result Handling

```dart
switch (result) {
  case Success(value: final data):
    // Handle success
    break;
  case Failure(errorResponse: final error):
    // Handle error
    break;
}
```

## 📚 Documentation Requirements

### Code Documentation

- Document all public APIs
- Include usage examples for complex features
- Explain business logic decisions
- Update architecture documentation for major changes

### File Organization

- Group related functionality in feature directories
- Use `part` and `part of` for related files
- Maintain consistent naming conventions
- Keep interfaces in dedicated directories

## 🚀 Performance Considerations

### Memory Management

- Dispose resources properly in BLoCs/Cubits
- Use lazy initialization where appropriate
- Avoid memory leaks in streams and subscriptions

### Network Optimization

- Implement proper caching strategies
- Handle network errors gracefully
- Use efficient data serialization

## 🔒 Security Guidelines

### Data Handling

- Never log sensitive information
- Use secure storage for credentials
- Validate all user inputs
- Handle authentication tokens securely

## 🌐 Localization Support

### Text Management

- Use localization constants from core/constants/
- Support multiple languages
- Test with different locales and text lengths

---

## 🚨 IMPORTANT - SDK DEVELOPERS ONLY

**This is specifically for Optimizely Commerce Flutter SDK core developers.** As SDK developers, you can modify any files in this codebase as needed for implementing features, fixing bugs, and improving architecture.

**Key Points for SDK Development:**

- ✅ **Full File Access**: Modify any file including base classes, interfaces, and core services
- ✅ **Architecture Changes**: Update fundamental patterns when needed for SDK improvement
- ✅ **Breaking Changes**: Implement when necessary for better SDK design (with proper versioning)
- ✅ **Direct Implementation**: Write code directly in core classes rather than extensions
- ⚠️ **Backward Compatibility**: Maintain when possible, but prioritize good architecture and functionality
- 📋 **Documentation**: Update API docs and architecture guides for major changes
- 🧪 **Testing**: Ensure comprehensive test coverage for all changes

**Remember**: This is NOT guidance for SDK consumers/clients - they should follow different patterns that avoid modifying SDK internals. This guidance is exclusively for the core SDK development team at Optimizely.
