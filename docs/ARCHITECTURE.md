# Architecture Documentation

## Optimizely Configured Commerce Mobile UI SDK

This document provides a comprehensive overview of the architecture, design patterns, and technical implementation of the Optimizely Configured Commerce Mobile UI SDK.

## 📱 Project Overview

The **Optimizely Configured Commerce Mobile UI SDK** is a comprehensive Flutter-based mobile commerce application that provides a customizable native mobile experience for Optimizely Configured Commerce. It's designed as a complete B2B commerce solution with both UI components and API integration capabilities.

### Key Characteristics

- **Platform:** Cross-platform Flutter application (iOS, Android)
- **Architecture:** Clean Architecture with SOLID principles
- **State Management:** BLoC/Cubit pattern
- **API Integration:** Custom Dart SDK for Optimizely Commerce API
- **Target Market:** B2B commerce applications

## 🏗️ Architecture Overview

### Clean Architecture Layers

The project follows Clean Architecture principles with clear separation of concerns:

```text
┌─────────────────────────────────────────┐
│            Presentation Layer           │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │   Screens   │  │  BLoC/Cubits    │   │
│  │   Widgets   │  │  States/Events  │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│             Domain Layer                │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │  Use Cases  │  │    Entities     │   │
│  │ Interfaces  │  │     Enums       │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│              Data Layer                 │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │  Services   │  │  Repositories   │   │
│  │ Data Sources│  │    Models       │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
```

### Directory Structure

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
│   ├── config/              # Configuration files
│   ├── constants/           # App constants
│   ├── exceptions/          # Custom exceptions
│   ├── extensions/          # Dart extensions
│   ├── injection/           # Dependency injection
│   ├── mixins/              # Reusable mixins
│   └── utils/               # Utility functions
├── services/                # External service implementations
└── src/                     # Internal SDK components
    ├── app.dart             # Main app widget
    └── initializers/        # App initialization logic
```

## 🔧 Core Components

### State Management

#### BLoC Pattern

Used for complex state management with events and states:

```dart
class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsUseCase _productDetailsUseCase;
  
  ProductDetailsBloc({required ProductDetailsUseCase productDetailsUseCase})
      : _productDetailsUseCase = productDetailsUseCase,
        super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetailsEvent);
  }
}
```

#### Cubit Pattern

Used for simpler state management:

```dart
class DomainCubit extends Cubit<DomainState> {
  final DomainUsecase _domainUsecase;

  DomainCubit({required DomainUsecase domainUsecase})
      : _domainUsecase = domainUsecase,
        super(DomainUnknown());
}
```

### Dependency Injection

Uses GetIt service locator pattern for dependency management:

```dart
// Core registration
sl.registerLazySingleton<IAccountService>(() => AccountService(
  clientService: sl(),
  networkService: sl(),
  cacheService: sl(),
));

// BLoC registration
sl.registerFactory(() => ProductDetailsBloc(productDetailsUseCase: sl()));
```

### Use Cases

Business logic is encapsulated in use cases following the Single Responsibility Principle:

```dart
class LoginUsecase {
  Future<LoginStatus> login(String username, String password) async {
    // Business logic for login
  }
}
```

## 🌐 API Integration

### Commerce Dart SDK

The project includes a custom Dart SDK (`commerce-dart-sdk`) for API integration:

```dart
// Service Provider Pattern
class CommerceAPIServiceProvider implements ICommerceAPIServiceProvider {
  @override
  IAccountService getAccountService() => sl<IAccountService>();
  
  @override
  IAuthenticationService getAuthenticationService() => sl<IAuthenticationService>();
}
```

### API Architecture

- **HTTP Client:** Dio-based networking with interceptors
- **Authentication:** OAuth2 with automatic token refresh
- **Cookie Management:** Persistent session cookies with secure storage
- **Error Handling:** Centralized error management with retry logic
- **Request/Response Flow:** Interceptor-based request processing
- **Result Pattern:** Success/Failure result types

```dart
// HTTP Client Configuration
void _createClient() {
  var baseOptions = BaseOptions(
    headers: {
      Headers.contentTypeHeader: Headers.jsonContentType,
      HeaderConstants.userAgentHeader: HeaderConstants.userAgentType,
    },
  );
  client = Dio(baseOptions);
  
  // Cookie management
  cookieJar = CommerceCookieJar();
  client.interceptors.add(CookieManager(cookieJar));
  
  // Automatic token refresh interceptor
  client.interceptors.add(InterceptorsWrapper(onError: (e, handler) async {
    // Handle 401 errors with automatic token refresh
  }));
}
```

```dart
sealed class Result<T, E> {}
class Success<T, E> extends Result<T, E> {
  final T value;
  final int? statusCode;
  Success(this.value, {this.statusCode});
}
class Failure<T, E> extends Result<T, E> {
  final E errorResponse;
  Failure(this.errorResponse);
}
```

### Caching Implementation

The application uses a straightforward caching approach:

```dart
class CacheService implements ICacheService {
  final SharedPreferences sharedPreferences;
  
  // Cache durations
  int get offlineCacheMinutes => 5;
  int get onlineCacheMinutes => 5;
  
  // Local storage operations
  Future<bool> persistData<T>(String key, T value) async {
    await sharedPreferences.setString(key, jsonEncode(value));
    return true;
  }
  
  Future<T> loadPersistedData<T>(String key) async {
    if (sharedPreferences.containsKey(key)) {
      return jsonDecode(sharedPreferences.getString(key)!) as T;
    }
    throw Exception('Data not found in cache');
  }
}
```

**Cached Data Types:**

- Search history and location search queries
- Session state and authentication tokens
- VMI location data
- Quick order items
- Content management data

## 📱 Feature Modules

### E-commerce Core Features

#### Product Management

- **Product Catalog:** Browse and search products
- **Product Details:** Detailed product information with variants
- **Pricing & Inventory:** Real-time pricing and stock information
- **Style Traits:** Product configuration and variants

#### Shopping Experience

- **Shopping Cart:** Add, remove, modify cart items
- **Wishlist:** Save products for later
- **Search:** Advanced product search with filters
- **Barcode Scanning:** ML Kit integration for product lookup

#### Checkout & Orders

- **Checkout Flow:** Multi-step checkout process
- **Payment Integration:**
  - **TokenEx:** Secure payment tokenization
  - **Spreedly:** Payment gateway integration with iframe support
  - **3D Secure (3DS):** Enhanced payment authentication and fraud protection
- **Order Management:** Order history and tracking
- **Invoice Management:** B2B invoice handling

### B2B Specific Features

#### Account Management

- **Multi-user Accounts:** Support for multiple users per account
- **Account Hierarchy:** Organizational account structure
- **User Permissions:** Role-based access control

#### B2B Workflows

- **Quote Management:** Request and manage quotes
- **Order Approval:** Approval workflows for orders
- **Sales Rep Management:** Sales representative interactions
- **VMI (Vendor Managed Inventory):** Inventory management for vendors

### Content Management System (CMS)

#### Mobile CMS Integration

The application features a comprehensive **Mobile Content Management System** that allows administrators to customize screen layouts and content from the **B2B Admin Console Dashboard**. This enables dynamic content configuration without requiring app updates.

#### Customizable Screens

- **Account Screen:** Configurable widgets for user account management
- **Shop Screen:** Customizable product browsing and catalog layouts
- **Search Screen:** Flexible search interface and result presentation
- **Cart Screen:** Dynamic cart layout and checkout flow customization
- **VMI Screens:** Vendor-managed inventory interface customization(local)

#### CMS Widget Types

The system supports various widget entities that can be configured and arranged:

```dart
// Core CMS widget types available for screen customization
- CartContentsWidget: Shopping cart item display
- CartButtonsWidget: Cart action buttons and controls
- CarouselWidget: Image and content carousels
- ProductCarouselWidget: Product recommendation displays
- ActionsWidget: Custom action buttons and links
- SearchHistoryWidget: Recent search display
- PreviousOrdersWidget: Order history widgets
- OrderSummaryWidget: Order details and totals
- ShippingMethodWidget: Delivery options
- LocationNoteWidget: Location-specific information
- CurrentLocationWidget: Location services integration
- HeaderWidget: Customizable page headers
- SpacerWidget: Layout spacing elements
```

#### CMS Architecture

```dart
// Content management flow
PageContentType → CmsUseCase → ContentConfigurationService → WidgetEntity[]

// Supported page types for customization
enum PageContentType { 
  shop,           // Product catalog and browsing
  searchLanding,  // Search interface and results
  account,        // User account management
  vmiMain,        // VMI dashboard
  cart            // Shopping cart and checkout
}
```

#### Admin Console Integration

- **Live Content Management:** Real-time content updates from admin dashboard
- **Widget Configuration:** Drag-and-drop widget arrangement

#### Implementation Benefits

- **Dynamic UI:** Change screen layouts without app store updates
- **Personalization:** Custom experiences based on user roles
- **Brand Customization:** Tailor interface to company branding
- **Feature Flags:** Enable/disable features through CMS configuration

### Mobile-Specific Features

#### Device Integration

- **Biometric Authentication:** Fingerprint/Face ID login
- **Camera Integration:** Barcode scanning
- **Location Services:** Store locator and location-based features
- **Push Notifications:** Firebase messaging integration

## 🔐 Security & Authentication

### Authentication Flow

1. **Client Credentials:** OAuth2 client authentication
2. **User Authentication:** Username/password or biometric login
3. **Token Management:** Secure storage of access/refresh tokens
4. **Session Management:** Automatic token refresh and session handling

### Security Measures

- **Secure Storage:** Flutter Secure Storage for sensitive data
- **API Security:** Standard HTTPS encryption with SSL/TLS
- **Biometric Security:** Device-level authentication
- **Data Encryption:** Encrypted local storage

## 🧪 Testing Strategy

### Test Architecture

```dart
test/
├── features/
│   ├── domain/              # Domain layer tests
│   │   ├── usecases/        # Use case tests
│   │   └── mapper/          # Entity mapping tests
│   └── presentation/        # Presentation layer tests
│       ├── bloc/            # BLoC tests
│       └── cubit/           # Cubit tests
├── sdk/                     # Mock services and utilities
└── commerce-dart-sdk/       # API SDK tests
```

### Testing Patterns

#### BLoC Testing

```dart
blocTest<DomainCubit, DomainState>(
  'emits [DomainOperationInProgress, DomainLoaded] when selectDomain succeeds',
  build: () => DomainCubit(domainUsecase: mockDomainUsecase),
  act: (cubit) => cubit.selectDomain('validDomain'),
  expect: () => [
    DomainOperationInProgress(),
    DomainLoaded('validDomain'),
  ],
);
```

#### Mock Services

```dart
class MockLoginUsecase extends Mock implements LoginUsecase {}

when(() => mockLoginUsecase.login(any(), any()))
    .thenAnswer((_) async => LoginStatus.success);
```

### Test Coverage

- **Unit Tests:** Business logic and use cases
- **Widget Tests:** UI component testing
- **Integration Tests:** End-to-end workflows
- **API Tests:** Service layer testing

## 🔧 Configuration Management

### Environment Configuration

#### Base Configuration (`assets/config/base_config.json`)

```json
{
    "domain": "your-commerce-domain.com",
    "checkoutUrl": null,
    "startingCategoryForBrowsing": null,
    "hasCheckout": true,
    "viewOnWebsiteEnabled": true,
    "customHideCheckoutOrderNotes": false,
    "firebaseAndroidApiKey":"",
    "firebaseAndroidAppId":"",
    "firebaseAndroidMessagingSenderId":"",
    "firebaseAndroidProjectId":"",
    "firebaseAndroidStorageBucket":"",
    "firebaseIOSApiKey":"",
    "firebaseIOSAppId":"",
    "firebaseIOSMessagingSenderId":"",
    "firebaseIOSProjectId":"",
    "firebaseIOSStorageBucket":"",
    "firebaseIOSBundleId":""
}
```

#### Client Configuration

```dart
void init() {
  ClientConfig.hostUrl = null;
  ClientConfig.clientId = ProdConfigConstants.clientId;
  ClientConfig.clientSecret = ProdConfigConstants.clientSecret;
}
```

### Build Configurations

- **Development:** Debug builds with logging enabled
- **Staging:** Pre-production testing environment
- **Production:** Release builds with optimizations

## 🚀 Performance Considerations

### Optimization Strategies

- **Lazy Loading:** On-demand loading of heavy components
- **Image Optimization:** Cached image loading and optimization
- **Memory Management:** Proper disposal of resources
- **Network Optimization:** Request batching and caching

### Monitoring

- **Crashlytics:** Crash reporting and analysis
- **Custom Logging:** Configurable logging levels

## 🔄 Data Flow

### Typical Data Flow

1. **UI Event:** User interaction triggers an event
2. **BLoC/Cubit:** State management handles the event
3. **Use Case:** Business logic processes the request
4. **Service:** API call or data operation
5. **Result:** Success/failure result returned
6. **State Update:** UI reflects the new state

### Example Flow - Product Loading

```dart
User taps product → ProductDetailsBloc → FetchProductDetailsEvent 
→ ProductDetailsUseCase → APIService → API Call 
→ Result<ProductEntity> → ProductDetailsState → UI Update
```

## 📦 Deployment Architecture

### Build Process

1. **Asset Processing:** Image and configuration processing
2. **Code Generation:** JSON serialization and localization
3. **Platform Builds:** iOS IPA and Android APK/AAB generation
4. **Distribution:** App Store and Play Store deployment

### CI/CD Pipeline

- **Automated Testing:** Unit and integration test execution
- **Code Quality:** Linting and static analysis
- **Build Automation:** Platform-specific build generation
- **Distribution:** Automated deployment to stores

## 🛠️ Development Guidelines

### Code Organization

- **Feature-based:** Organize code by business features
- **Layer Separation:** Maintain clean architecture boundaries
- **Dependency Direction:** Dependencies point inward to domain layer
- **Interface Segregation:** Small, focused interfaces

### Naming Conventions

- **Files:** snake_case for file names
- **Classes:** PascalCase for class names
- **Variables:** camelCase for variables and methods
- **Constants:** SCREAMING_SNAKE_CASE for constants

### Best Practices

- **Single Responsibility:** One responsibility per class/method
- **Dependency Injection:** Use DI for all dependencies
- **Error Handling:** Consistent error handling patterns
- **Testing:** Test-driven development approach

This architecture documentation serves as a guide for developers working on the Optimizely Configured Commerce Mobile UI SDK, ensuring consistent development practices and architectural decisions.
