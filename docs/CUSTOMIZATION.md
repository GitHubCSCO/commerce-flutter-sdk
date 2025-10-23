# Customization Guide

## Optimizely Configured Commerce Mobile UI SDK

This guide provides best practices and patterns for third-party developers to customize and extend the Optimizely Configured Commerce Mobile UI SDK while maintaining compatibility with future base code updates.

## 📋 Table of Contents

- [Overview](#overview)
- [Extension Patterns](#extension-patterns)
- [Customization Areas](#customization-areas)
- [Best Practices](#best-practices)
- [Safe Customization Zones](#safe-customization-zones)
- [Avoid Modifying](#avoid-modifying)
- [Commerce Dart SDK Modifications](#commerce-dart-sdk-modifications)
- [Configuration Management](#configuration-management)
- [Custom Widget Development](#custom-widget-development)
- [Service Extension](#service-extension)
- [Theme Customization](#theme-customization)
- [Conflict Prevention](#conflict-prevention)
- [Testing Custom Code](#testing-custom-code)

## 🔍 Overview

The SDK is built using Clean Architecture principles with clear separation of concerns. This architecture provides multiple extension points for customization without modifying core functionality.

### Key Principles for Safe Customization

1. **Extend, Don't Modify**: Use inheritance and composition rather than directly editing core files
2. **Interface-Based**: Leverage existing interfaces for custom implementations
3. **Configuration-Driven**: Use configuration files and dependency injection for customization
4. **Layer Respect**: Maintain clean architecture boundaries
5. **Future-Proof**: Follow patterns that won't conflict with SDK updates

## 🔧 Extension Patterns

### 1. Interface Implementation

The SDK provides numerous interfaces that can be implemented for custom behavior:

```dart
// Example: Custom service implementation
class CustomBiometricAuthService implements IBiometricAuthenticationService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  
  CustomBiometricAuthService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
  }) : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  @override
  Future<bool> authenticate(String password) async {
    // Add your custom pre-authentication logic
    await logAuthenticationAttempt();
    await validateWithCustomSecurityRules(password);
    
    // Use SDK's commerce API services
    final userName = _commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.userName;
    
    if (userName == null) return false;
    
    final response = await _commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(userName, password);
    
    switch (response) {
      case Success(value: bool? value):
        // Add custom post-authentication logic
        await trackSuccessfulAuth(userName);
        return value ?? false;
      case Failure():
        return false;
    }
  }
  
  Future<void> logAuthenticationAttempt() async {
    // Your custom logging logic
  }
  
  Future<void> validateWithCustomSecurityRules(String password) async {
    // Your custom validation logic (e.g., check against breached passwords)
  }
  
  Future<void> trackSuccessfulAuth(String userName) async {
    // Your custom analytics tracking
  }
  
  // Implement other required interface methods with your custom logic
  @override
  Future<bool> enableBiometricAuthentication(String password) async {
    // Your implementation
  }
  
  // ... other interface methods
}
```
```dart
// Register in dependency injection to override default service
sl.registerLazySingleton<IBiometricAuthenticationService>(
  () => CustomBiometricAuthService(
    commerceAPIServiceProvider: sl(),
  ),
);
```

### 2. UseCase Extension

Extend base use cases for custom business logic:

```dart
class CustomOrderUsecase extends OrderUsecase {
  @override
  Future<GetOrderCollectionResultEntity?> getOrderHistory({
    int? page,
    OrderSortOrder sortOrder = OrderSortOrder.orderDateDescending,
    bool showMyOrders = false,
    List<String> filterAttributes = const [],
    bool isFromVMI = false,
    required String searchText,
  }) async {
    // Add custom pre-processing
    await logOrderHistoryRequest(searchText);
    await validateOrderPermissions();
    
    // Call parent implementation
    final result = await super.getOrderHistory(
      page: page,
      sortOrder: sortOrder,
      showMyOrders: showMyOrders,
      filterAttributes: filterAttributes,
      isFromVMI: isFromVMI,
      searchText: searchText,
    );
    
    // Add custom post-processing
    if (result != null && result.orders != null) {
      return GetOrderCollectionResultEntity(
        pagination: result.pagination,
        orders: await enrichOrdersWithCustomData(result.orders!),
        showErpOrderNumber: result.showErpOrderNumber,
      );
    }
    
    return result;
  }
  
  Future<void> logOrderHistoryRequest(String searchText) async {
    // Your custom analytics/logging logic
  }
  
  Future<void> validateOrderPermissions() async {
    // Your custom permission validation
  }
  
  Future<List<OrderEntity>> enrichOrdersWithCustomData(List<OrderEntity> orders) async {
    // Add custom data like estimated delivery dates, loyalty points, etc.
    return orders;
  }
}
```

### 3. Widget Extension

Create custom widgets using composition:

```dart
class CustomProductCard extends StatelessWidget {
  final ProductEntity product;
  
  const CustomProductCard({Key? key, required this.product}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Use existing SDK widgets
          ProductImageWidget(product: product),
          // Add custom elements
          CustomBrandBadge(brand: product.brand),
          // Use existing SDK widgets
          ProductPriceWidget(product: product),
        ],
      ),
    );
  }
}
```

## 🎯 Customization Areas

### Safe Areas for Customization

#### 1. Configuration Files

- `assets/config/base_config.json` - App configuration
- Custom configuration files in `assets/config/`
- Environment-specific configurations

#### 2. Custom Features Directory

Create your custom features in a separate directory:

```text
lib/
├── custom_features/          # Your custom features
│   ├── custom_analytics/     # Custom analytics implementation
│   ├── custom_widgets/       # Custom UI components
│   ├── custom_services/      # Custom service implementations
│   └── custom_usecases/      # Custom business logic
```

#### 3. Theme and Styling

See the [Theme Customization](#theme-customization) section for detailed guidance on customizing colors and themes using `OptiAppColors` and backend-driven configuration.

#### 4. Custom API Extensions

```dart
// Custom API service
class CustomProductService extends BaseUseCase implements ICustomProductService {
  Future<Result<List<ProductEntity>, ErrorResponse>> getRecommendedProducts() async {
    // Custom API call
    final result = await commerceAPIServiceProvider
        .getClientService()
        .getAsync('/api/custom/recommended-products');
    
    switch (result) {
      case Success(value: final response):
        return Success(parseProducts(response.data));
      case Failure(errorResponse: final error):
        return Failure(error);
    }
  }
}
```

## ✅ Best Practices

### 1. Dependency Injection Pattern

The SDK uses `CommerceFlutterSDK.initialize()` as the entry point. Use the `overrideServices` callback to register your custom services after the SDK's core injection container is initialized.

```dart
await CommerceFlutterSDK.initialize(
  config: CommerceConfig(
    isRunningAsPackage: false,
    overrideServices: (serviceLocator) async {
      // Register custom services
      serviceLocator.registerLazySingleton<ICustomAnalytics>(
        () => CustomAnalyticsService(),
      );
      
      serviceLocator.registerLazySingleton<ICustomProductService>(
        () => CustomProductService(),
      );
      
      // Override default SDK services if needed
      // Note: Unregister the existing service first, then register your custom one
      if (serviceLocator.isRegistered<IBiometricAuthenticationService>()) {
        await serviceLocator.unregister<IBiometricAuthenticationService>();
      }
      serviceLocator.registerLazySingleton<IBiometricAuthenticationService>(
        () => CustomBiometricAuthService(
          commerceAPIServiceProvider: serviceLocator(),
        ),
      );
    },
  ),
);
```

**Important Notes:**
- The `overrideServices` callback is executed after `initInjectionContainer()` completes
- Use `serviceLocator.unregister()` before overriding existing SDK services
- Register custom services that extend SDK functionality
- Keep all custom service registrations in the `overrideServices` callback to avoid conflicts with SDK updates

### 2. Configuration-Driven Customization

```dart
// Custom configuration model
class CustomConfiguration {
  final bool enableCustomFeature;
  final String customApiEndpoint;
  final Map<String, dynamic> customSettings;
  
  CustomConfiguration.fromJson(Map<String, dynamic> json)
    : enableCustomFeature = json['enableCustomFeature'] ?? false,
      customApiEndpoint = json['customApiEndpoint'] ?? '',
      customSettings = json['customSettings'] ?? {};
}

// Load and use configuration
class CustomConfigService {
  static CustomConfiguration? _config;
  
  static Future<void> loadConfiguration() async {
    final configString = await rootBundle.loadString('assets/config/custom_config.json');
    final configJson = json.decode(configString);
    _config = CustomConfiguration.fromJson(configJson);
  }
  
  static CustomConfiguration get config => _config!;
}
```

### 3. Custom BLoC/Cubit Implementation

```dart
// Custom feature BLoC
class CustomFeatureBloc extends Bloc<CustomFeatureEvent, CustomFeatureState> {
  final ICustomProductService _customProductService;
  
  CustomFeatureBloc({required ICustomProductService customProductService})
      : _customProductService = customProductService,
        super(CustomFeatureInitial()) {
    on<LoadCustomDataEvent>(_onLoadCustomData);
  }
  
  void _onLoadCustomData(LoadCustomDataEvent event, Emitter<CustomFeatureState> emit) async {
    emit(CustomFeatureLoading());
    
    final result = await _customProductService.getCustomData();
    switch (result) {
      case Success(value: final data):
        emit(CustomFeatureLoaded(data));
      case Failure(errorResponse: final error):
        emit(CustomFeatureError(error.message));
    }
  }
}
```

## 🚫 Avoid Modifying

### Core Files to Never Modify Directly

#### 1. Base SDK Files

- `lib/src/features/domain/usecases/base_usecase.dart`
- `lib/src/core/injection/injection_container.dart` (core registrations)
- `lib/commerce_flutter_sdk.dart`

#### 2. Core Service Interfaces

- Files in `lib/src/features/domain/service/interfaces/`
- Core entity definitions
- Result types and base models

#### 3. Core Architecture Components

- Base BLoC/Cubit classes
- Core state management patterns
- Core routing logic

### Why Avoid Direct Modifications?

1. **Update Conflicts**: Direct modifications will conflict during SDK updates
2. **Maintainability**: Harder to track custom changes
3. **Testing**: Breaks SDK's test coverage
4. **Support**: Custom modifications void support

## 🔧 Commerce Dart SDK Modifications

### Modifying commerce-dart-sdk

The `commerce-dart-sdk` is a separate package that CAN be modified for custom requirements, but developers should follow these guidelines to ensure easy synchronization with future base code updates:

#### Safe Commerce SDK Modification Patterns

##### 1. Extension-Based Modifications

```dart
// Instead of modifying existing models, create extensions
// File: commerce-dart-sdk/lib/src/extensions/product_extensions.dart
extension CustomProductExtensions on Product {
  bool get isCustomCategory => categoryId == 'custom-category-id';
  
  String get customDisplayName => 
    customProperties?['displayName'] ?? name ?? '';
  
  Map<String, dynamic> get customAnalyticsData => {
    'product_id': id,
    'brand': brand?.name,
    'custom_category': isCustomCategory,
  };
}
```

##### 2. Model Enhancements with Backwards Compatibility

```dart
// File: commerce-dart-sdk/lib/src/models/custom_product.dart
// Create new models that extend base models
class CustomProduct extends Product {
  final String? customField1;
  final Map<String, dynamic>? customProperties;
  final CustomBrandInfo? enhancedBrand;
  
  CustomProduct({
    // Include all parent constructor parameters
    required super.id,
    super.name,
    super.brand,
    // Add custom parameters
    this.customField1,
    this.customProperties,
    this.enhancedBrand,
  });
  
  factory CustomProduct.fromProduct(Product product, {
    String? customField1,
    Map<String, dynamic>? customProperties,
  }) {
    return CustomProduct(
      id: product.id,
      name: product.name,
      brand: product.brand,
      // ... copy all base properties
      customField1: customField1,
      customProperties: customProperties,
    );
  }
}
```

##### 3. Service Interface Extensions

```dart
// File: commerce-dart-sdk/lib/src/interfaces/custom_product_service_interface.dart
abstract class ICustomProductService extends IProductService {
  Future<Result<List<CustomProduct>, ErrorResponse>> getCustomProducts();
  Future<Result<CustomProduct, ErrorResponse>> getCustomProductDetails(String id);
}

// File: commerce-dart-sdk/lib/src/services/custom_product_service.dart
class CustomProductService extends ProductService implements ICustomProductService {
  
  @override
  Future<Result<List<CustomProduct>, ErrorResponse>> getCustomProducts() async {
    // Custom implementation that leverages base service
    final baseResult = await super.getProducts();
    
    switch (baseResult) {
      case Success(value: final products):
        return Success(
          products.map((p) => CustomProduct.fromProduct(p)).toList()
        );
      case Failure(errorResponse: final error):
        return Failure(error);
    }
  }
}
```

#### Commerce SDK Modification Guidelines

##### DO

- **Create new files** for custom functionality
- **Use extensions** to add functionality to existing models
- **Inherit from base classes** rather than modifying them
- **Add new interfaces** for custom services
- **Document all changes** thoroughly
- **Maintain backwards compatibility**
- **Use consistent naming** with 'Custom' prefix

##### DON'T

- **Modify existing model files** directly
- **Change existing API contracts**
- **Remove or rename existing properties**
- **Modify core service implementations** without inheritance
- **Break existing functionality**

#### Directory Structure for Commerce SDK Customizations

```text
commerce-dart-sdk/
├── lib/
│   ├── src/
│   │   ├── models/
│   │   │   ├── product.dart          # Base model (don't modify)
│   │   │   └── custom_product.dart   # Your custom model
│   │   ├── services/
│   │   │   ├── product_service.dart     # Base service (don't modify)
│   │   │   └── custom_product_service.dart  # Your custom service
│   │   ├── interfaces/
│   │   │   └── custom_product_service_interface.dart  # Your interfaces
│   │   ├── extensions/
│   │   │   ├── product_extensions.dart      # Your extensions
│   │   │   └── custom_model_extensions.dart # More extensions
│   │   └── utils/
│   │       └── custom_helpers.dart    # Custom utility functions
│   └── optimizely_commerce_api.dart   # Main export (may need updates)
```

#### Version Control Best Practices

##### Track Your Changes

```dart
// File: commerce-dart-sdk/CUSTOM_CHANGES.md
# Custom Modifications Log

## Version 1.0.0
- Added CustomProduct model with enhanced properties
- Created CustomProductService for extended functionality
- Added ProductExtensions for analytics data

## Version 1.1.0
- Added CustomOrderService for enhanced order processing
- Extended Account model with custom properties

## Sync Notes
- Base SDK version: 2.1.0
- Last sync date: 2024-01-15
- Conflicts resolved: None
- Custom files: [list of files]
```

##### Use Git Branching Strategy

```bash
# Create a custom branch for your modifications
git checkout -b custom-modifications

# Keep track of base SDK updates
git remote add upstream [base-sdk-repository]
git fetch upstream

# Merge base updates into your custom branch
git checkout custom-modifications
git merge upstream/main  # Resolve conflicts as needed
```

#### Testing Custom Commerce SDK Changes

```dart
// File: commerce-dart-sdk/test/custom/custom_product_test.dart
void main() {
  group('CustomProduct', () {
    test('should create custom product from base product', () {
      final baseProduct = Product(id: '123', name: 'Test Product');
      final customProduct = CustomProduct.fromProduct(
        baseProduct, 
        customField1: 'custom-value'
      );
      
      expect(customProduct.id, equals('123'));
      expect(customProduct.name, equals('Test Product'));
      expect(customProduct.customField1, equals('custom-value'));
    });
    
    test('should maintain backwards compatibility', () {
      final customProduct = CustomProduct(id: '123', name: 'Test');
      
      // Should work as base Product
      Product baseProduct = customProduct;
      expect(baseProduct.id, equals('123'));
    });
  });
}
```

#### Upgrade Path Strategy

```dart
class CommerceSDKUpgradeHelper {
  static void validateCustomChanges() {
    // Check if custom changes are compatible with new base version
    print('Validating custom modifications...');
    
    // List custom files
    final customFiles = [
      'lib/src/models/custom_product.dart',
      'lib/src/services/custom_product_service.dart',
      'lib/src/extensions/product_extensions.dart',
    ];
    
    for (final file in customFiles) {
      if (_fileExists(file)) {
        print('✓ Custom file exists: $file');
      }
    }
  }
  
  static List<String> getModifiedBaseFiles() {
    // Return list of base files that were modified (should be empty)
    return [];
  }
}
```

## 🏗️ Safe Customization Zones

### 1. Screen Customization

```dart
// Create custom screens that use SDK components
class CustomProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Products')),
      body: BlocBuilder<CustomProductBloc, CustomProductState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                // Use custom widget that wraps SDK components
                return CustomProductCard(product: state.products[index]);
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
```

### 2. Route Customization

```dart
// Custom route definitions
class CustomRoutes {
  static const String customProductList = '/custom-products';
  static const String customCheckout = '/custom-checkout';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case customProductList:
        return MaterialPageRoute(builder: (_) => CustomProductListScreen());
      case customCheckout:
        return MaterialPageRoute(builder: (_) => CustomCheckoutScreen());
      default:
        // Fallback to SDK routes
        return AppRoute.generateRoute(settings);
    }
  }
}
```

### 3. Custom Payment Integration

```dart
// Custom payment service
class CustomPaymentService implements IPaymentService {
  @override
  Future<Result<PaymentResult, ErrorResponse>> processPayment(PaymentRequest request) async {
    // Your custom payment processing logic
    try {
      final result = await customPaymentGateway.processPayment(request);
      return Success(PaymentResult.fromCustomResult(result));
    } catch (e) {
      return Failure(ErrorResponse(message: e.toString()));
    }
  }
}
```

## ⚙️ Configuration Management

The SDK includes an `AppConfigurationService` that automatically loads configuration from two files:
- `assets/config/base_config.json` - Base SDK configuration
- `assets/config/custom_config.json` - Your custom configuration

### Using Custom Configuration

The SDK's `CustomConfiguration` class is already loaded by `AppConfigurationService` during initialization. Add your custom settings to `assets/config/custom_config.json`:

```json
// assets/config/custom_config.json
{
  "features": {
    "enableCustomAnalytics": true,
    "enableLoyaltyProgram": false,
    "customRecommendations": true
  },
  "integrations": {
    "customPaymentGateway": {
      "apiKey": "your-api-key",
      "environment": "sandbox"
    },
    "customAnalytics": {
      "trackingId": "your-tracking-id",
      "endpoint": "https://analytics.yourcompany.com"
    }
  },
  "ui": {
    "customLayoutGrid": 3,
    "showCustomBadges": true,
    "enableDarkMode": false
  },
  "businessLogic": {
    "maxCartItems": 100,
    "enableBackorders": true,
    "shippingCalculationMode": "realtime"
  }
}
```

### Accessing Configuration in Your Code

Access the configuration through the SDK's `AppConfigurationService`:

```dart
// Get the configuration service
final appConfigService = sl<IAppConfigurationService>();

// Access custom configuration
final customConfig = appConfigService.customConfig;

// Check feature flags
if (customConfig?.features?['enableCustomAnalytics'] == true) {
  // Initialize custom analytics
  await CustomAnalyticsService.initialize();
}

// Access integration settings
final apiKey = customConfig?.integrations?['customPaymentGateway']?['apiKey'];
final environment = customConfig?.integrations?['customPaymentGateway']?['environment'];

// Access UI settings
final gridSize = customConfig?.ui?['customLayoutGrid'] ?? 2;
final showBadges = customConfig?.ui?['showCustomBadges'] ?? false;

// Access business logic settings
final maxCartItems = customConfig?.businessLogic?['maxCartItems'] ?? 50;
```

### Extending CustomConfiguration

If you need strongly-typed access to your custom settings, create extension methods:

```dart
extension CustomConfigurationExtensions on CustomConfiguration {
  // Feature flags
  bool get enableCustomAnalytics => 
      features?['enableCustomAnalytics'] == true;
  
  bool get enableLoyaltyProgram => 
      features?['enableLoyaltyProgram'] == true;
  
  // Integration settings
  String? get customAnalyticsEndpoint => 
      integrations?['customAnalytics']?['endpoint'];
  
  String? get customPaymentApiKey => 
      integrations?['customPaymentGateway']?['apiKey'];
  
  // UI settings
  int get customLayoutGrid => 
      ui?['customLayoutGrid'] ?? 2;
  
  bool get showCustomBadges => 
      ui?['showCustomBadges'] ?? false;
  
  // Business logic settings
  int get maxCartItems => 
      businessLogic?['maxCartItems'] ?? 50;
  
  bool get enableBackorders => 
      businessLogic?['enableBackorders'] ?? false;
}

// Usage
final appConfigService = sl<IAppConfigurationService>();
final customConfig = appConfigService.customConfig;

if (customConfig?.enableCustomAnalytics ?? false) {
  await initializeCustomAnalytics(
    endpoint: customConfig?.customAnalyticsEndpoint,
  );
}
```

### Configuration-Based Service Initialization

Use custom configuration to conditionally initialize services:

```dart
await CommerceFlutterSDK.initialize(
  config: CommerceConfig(
    isRunningAsPackage: false,
    overrideServices: (serviceLocator) async {
      // Get configuration service
      final appConfigService = serviceLocator<IAppConfigurationService>();
      final customConfig = appConfigService.customConfig;
      
      // Conditionally register services based on configuration
      if (customConfig?.features?['enableCustomAnalytics'] == true) {
        serviceLocator.registerLazySingleton<ICustomAnalytics>(
          () => CustomAnalyticsService(
            trackingId: customConfig?.integrations?['customAnalytics']?['trackingId'],
            endpoint: customConfig?.integrations?['customAnalytics']?['endpoint'],
          ),
        );
      }
      
      if (customConfig?.features?['enableLoyaltyProgram'] == true) {
        serviceLocator.registerLazySingleton<ILoyaltyService>(
          () => LoyaltyService(),
        );
      }
    },
  ),
);
```

## 🎨 Custom Widget Development

### Widget Extension Pattern

```dart
// Base widget wrapper
abstract class CustomWidgetWrapper extends StatelessWidget {
  final Widget child;
  const CustomWidgetWrapper({Key? key, required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getCustomDecoration(),
      child: child,
    );
  }
  
  BoxDecoration getCustomDecoration();
}

// Specific implementation
class CustomProductCardWrapper extends CustomWidgetWrapper {
  const CustomProductCardWrapper({Key? key, required Widget child}) 
      : super(key: key, child: child);
  
  @override
  BoxDecoration getCustomDecoration() {
    return BoxDecoration(
      border: Border.all(color: CustomColors.brandAccent),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    );
  }
}
```

### CMS Widget Integration

```dart
// Custom CMS widget factory
class CustomWidgetFactory {
  static Widget? buildCustomWidget(WidgetEntity widget) {
    switch (widget.subType) {
      case 'custom_promo_banner':
        return CustomPromoBannerWidget.fromEntity(widget);
      case 'custom_product_grid':
        return CustomProductGridWidget.fromEntity(widget);
      case 'custom_loyalty_card':
        return CustomLoyaltyCardWidget.fromEntity(widget);
      default:
        return null; // Let SDK handle standard widgets
    }
  }
}

// Register custom widget factory
class CustomCMSService extends CmsUseCase {
  @override
  Widget buildWidget(WidgetEntity widget) {
    final customWidget = CustomWidgetFactory.buildCustomWidget(widget);
    return customWidget ?? super.buildWidget(widget);
  }
}
```

## 🔌 Service Extension

### Custom Service Implementation

```dart
// Custom analytics service
class CustomAnalyticsService implements ITrackingService {
  final FirebaseAnalytics _firebaseAnalytics;
  final CustomAnalyticsSDK _customSDK;
  
  CustomAnalyticsService(this._firebaseAnalytics, this._customSDK);
  
  @override
  Future<void> trackEvent(String eventName, Map<String, dynamic> parameters) async {
    // Send to multiple analytics providers
    await _firebaseAnalytics.logEvent(name: eventName, parameters: parameters);
    await _customSDK.trackEvent(eventName, parameters);
    
    // Custom business logic
    if (eventName == 'product_viewed') {
      await _trackProductRecommendations(parameters['product_id']);
    }
  }
  
  Future<void> _trackProductRecommendations(String productId) async {
    // Custom recommendation tracking logic
  }
}
```

### Service Composition

```dart
// Compose existing services with custom functionality
class EnhancedProductService {
  final ProductDetailsUseCase _baseProductService;
  final CustomRecommendationService _recommendationService;
  final CustomInventoryService _inventoryService;
  
  EnhancedProductService(
    this._baseProductService,
    this._recommendationService,
    this._inventoryService,
  );
  
  Future<EnhancedProductEntity> getEnhancedProduct(String productId) async {
    final productResult = await _baseProductService.getProductDetails(productId);
    
    switch (productResult) {
      case Success(value: final product):
        final recommendations = await _recommendationService.getRecommendations(productId);
        final inventory = await _inventoryService.getInventoryData(productId);
        
        return EnhancedProductEntity(
          baseProduct: product,
          recommendations: recommendations,
          inventoryData: inventory,
        );
      case Failure(errorResponse: final error):
        throw Exception('Failed to load product: ${error.message}');
    }
  }
}
```

## 🎨 Theme Customization

The SDK uses a centralized theming system with `OptiAppColors` and backend-driven theme configuration. Colors and styles are dynamically loaded from your Optimizely Commerce backend.

### Understanding SDK Theme Architecture

The SDK's theme is managed through:
- **`OptiAppColors`** - Centralized color constants that can be modified at runtime
- **`getTheme()`** - Returns the base theme using current `OptiAppColors.primaryColor`
- **Backend Configuration** - Primary colors are loaded from your commerce backend
- **`CommerceApp`** - Root app widget that applies the theme

### Option 1: Backend-Driven Theme (Recommended)

The SDK automatically loads theme colors from your Optimizely Commerce backend. This is the preferred method as it allows non-developers to manage branding.

```dart
// The SDK handles this automatically
// Colors are fetched from backend and stored in OptiAppColors.primaryColor
// No code changes needed - configure in your Commerce admin panel
```

### Option 2: Customize OptiAppColors at Runtime

Override the primary color before SDK initialization or at runtime:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set custom primary color before initializing SDK
  OptiAppColors.primaryColor = const Color(0xFF1B365D);
  
  await CommerceFlutterSDK.initialize(
    config: CommerceConfig(
      isRunningAsPackage: false,
      overrideServices: (serviceLocator) async {
        // Optional: Register custom services here
      },
    ),
  );
}
```

### Option 3: Modify OptiAppColors Class Directly

For persistent color changes across the entire app:

```dart
// Create a custom colors file that extends/modifies OptiAppColors
class CustomBrandColors {
  static void applyCustomBranding() {
    // Override the primary color used throughout the SDK
    OptiAppColors.primaryColor = const Color(0xFF1B365D);
    
    // Note: Other OptiAppColors are const and cannot be changed at runtime
    // To modify them, you would need to edit the OptiAppColors class directly
  }
}

// Apply before SDK initialization
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CustomBrandColors.applyCustomBranding();
  
  await CommerceFlutterSDK.initialize(config: CommerceConfig());
}
```

### Option 4: Service Override for Advanced Theming

Use the service override mechanism to customize theme loading:

```dart
await CommerceFlutterSDK.initialize(
  config: CommerceConfig(
    isRunningAsPackage: false,
    overrideServices: (serviceLocator) async {
      // Override color loading service if needed
      // This runs after SDK's core setup but before theme initialization
      
      // Load custom brand configuration
      final customColor = await loadCustomBrandColor();
      OptiAppColors.primaryColor = customColor;
    },
  ),
);

Future<Color> loadCustomBrandColor() async {
  // Load from your custom configuration source
  // Could be a different API, local config, or environment variable
  return const Color(0xFF1B365D);
}
```

### Best Practices for Theme Customization

1. **Use Backend Configuration** - Manage colors through Commerce admin panel
2. **Set Before Initialization** - Modify `OptiAppColors.primaryColor` before calling `CommerceFlutterSDK.initialize()`
3. **Avoid Modifying SDK Files** - Don't edit `OptiAppColors` or `getTheme()` directly
4. **Test Theme Changes** - Verify colors work across light/dark modes and all screens
5. **Consider Accessibility** - Ensure sufficient contrast ratios for readability

### How SDK Theme System Works

```dart
// SDK's theme system (for reference - don't modify)
ThemeData getTheme() {
  return ThemeData(
    colorScheme: colorScheme.copyWith(
      primary: OptiAppColors.primaryColor, // Dynamic color
    ),
    iconTheme: IconThemeData(
      color: OptiAppColors.primaryColor, // Used throughout SDK
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: OptiAppColors.primaryColor,
      ),
    ),
    // ... other theme properties
  );
}

// CommerceApp applies the theme automatically
class CommerceApp extends StatelessWidget {
  const CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: getTheme(), // SDK theme with OptiAppColors.primaryColor
      // ... router and other configuration
    );
  }
}
```

### Persisting Custom Colors

If you need to persist custom colors across app restarts:

```dart
class CustomColorPersistence {
  static const String _colorKey = 'custom_primary_color';
  
  static Future<void> saveCustomColor(Color color) async {
    final hexColor = color.value.toRadixString(16);
    await sl<ILocalStorageService>().save(_colorKey, hexColor);
    OptiAppColors.primaryColor = color;
  }
  
  static Future<void> loadCustomColor() async {
    final hexColor = await sl<ILocalStorageService>().load(_colorKey);
    if (hexColor != null && hexColor.isNotEmpty) {
      final colorValue = int.tryParse(hexColor, radix: 16);
      if (colorValue != null) {
        OptiAppColors.primaryColor = Color(colorValue);
      }
    }
  }
}

// Use before SDK initialization
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjectionContainer(); // Initialize service locator first
  await CustomColorPersistence.loadCustomColor();
  
  await CommerceFlutterSDK.initialize(config: CommerceConfig());
}
```

## 🛡️ Conflict Prevention

### 1. Namespace Your Code

```dart
// Use consistent prefixes for custom classes
class CustomProductDetailsBloc extends Bloc<...> {}
class CustomAnalyticsService implements ITrackingService {}
class CustomProductCard extends StatelessWidget {}

// Create custom directories
custom_features/
├── custom_analytics/
├── custom_payments/
├── custom_widgets/
└── custom_services/
```

### 2. Version Compatibility Checks

```dart
class CustomSDKCompatibility {
  static const String requiredSDKVersion = '1.0.0';
  static const String customExtensionVersion = '1.0.0';
  
  static bool isCompatible() {
    // Check SDK version compatibility
    final currentSDKVersion = SDKVersion.current;
    return _isVersionCompatible(currentSDKVersion, requiredSDKVersion);
  }
  
  static bool _isVersionCompatible(String current, String required) {
    // Version comparison logic
    return true; // Implement proper version checking
  }
  
  static void validateCompatibility() {
    if (!isCompatible()) {
      throw Exception('Custom extension v$customExtensionVersion is not compatible with SDK v${SDKVersion.current}');
    }
  }
}
```

### 3. Graceful Fallbacks

```dart
class CustomFeatureService {
  final IProductService _baseProductService;
  
  Future<ProductEntity> getProduct(String productId) async {
    try {
      // Try custom enhancement first
      return await getEnhancedProduct(productId);
    } catch (e) {
      // Fallback to base SDK functionality
      print('Custom enhancement failed, falling back to base: $e');
      final result = await _baseProductService.getProduct(productId);
      switch (result) {
        case Success(value: final product):
          return product;
        case Failure(errorResponse: final error):
          throw Exception(error.message);
      }
    }
  }
}
```

### 4. Feature Flags

```dart
class CustomFeatureFlags {
  static bool get enableCustomAnalytics => 
      CustomConfigurationService.isFeatureEnabled('customAnalytics');
  
  static bool get enableCustomCheckout => 
      CustomConfigurationService.isFeatureEnabled('customCheckout');
  
  static bool get enableCustomRecommendations => 
      CustomConfigurationService.isFeatureEnabled('customProductRecommendations');
}

// Use feature flags in your custom code
class CustomProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductDetailsWidget(),
        if (CustomFeatureFlags.enableCustomRecommendations)
          CustomRecommendationsWidget(),
        // Base functionality always available
        AddToCartButton(),
      ],
    );
  }
}
```

## 🧪 Testing Custom Code

### 1. Custom Test Structure

```text
test/
├── custom_features/
│   ├── custom_analytics/
│   │   ├── custom_analytics_service_test.dart
│   │   └── custom_analytics_bloc_test.dart
│   ├── custom_widgets/
│   │   └── custom_product_card_test.dart
│   └── integration/
│       └── custom_feature_integration_test.dart
```

### 2. Mock Custom Services

```dart
class MockCustomAnalyticsService extends Mock implements ICustomAnalyticsService {}

void main() {
  group('Custom Product Details', () {
    late CustomProductDetailsBloc bloc;
    late MockCustomAnalyticsService mockAnalytics;
    
    setUp(() {
      mockAnalytics = MockCustomAnalyticsService();
      bloc = CustomProductDetailsBloc(analyticsService: mockAnalytics);
    });
    
    test('should track custom event when product is viewed', () async {
      // Test your custom functionality
      when(() => mockAnalytics.trackProductView(any()))
          .thenAnswer((_) async {});
      
      bloc.add(ViewProductEvent('test-product'));
      
      verify(() => mockAnalytics.trackProductView('test-product')).called(1);
    });
  });
}
```

### 3. Integration Testing

```dart
void main() {
  group('Custom Feature Integration', () {
    testWidgets('custom product card displays correctly', (WidgetTester tester) async {
      // Test custom widgets in context
      await tester.pumpWidget(
        MaterialApp(
          home: CustomProductCard(product: mockProduct),
        ),
      );
      
      expect(find.byType(CustomBrandBadge), findsOneWidget);
      expect(find.text('Custom Feature'), findsOneWidget);
    });
  });
}
```

## 🚀 Deployment Considerations

### 1. Custom Asset Management

```yaml
# pubspec.yaml additions for custom assets
flutter:
  assets:
    - assets/config/custom_config.json
    - assets/custom_images/
    - assets/custom_fonts/
```

### 2. Custom Dependencies

```yaml
# Add custom dependencies separately
dependencies:
  # SDK dependencies (don't modify these)
  
  # Your custom dependencies
  custom_analytics_sdk: ^1.0.0
  custom_payment_gateway: ^2.1.0
  custom_ui_components: ^1.5.0
```

### 3. Build Configuration

```dart
// Custom build configurations
class CustomBuildConfig {
  static const bool enableCustomFeatures = bool.fromEnvironment('ENABLE_CUSTOM_FEATURES');
  static const String customApiEndpoint = String.fromEnvironment('CUSTOM_API_ENDPOINT');
  
  static void validateBuildConfig() {
    if (enableCustomFeatures && customApiEndpoint.isEmpty) {
      throw Exception('Custom API endpoint must be provided when custom features are enabled');
    }
  }
}
```

## 📝 Documentation Requirements

### 1. Document Your Customizations

```markdown
# Custom Features Documentation

## Overview
This document describes the custom features added to the Optimizely Commerce SDK.

## Custom Features
- Custom Analytics Integration
- Enhanced Product Recommendations  
- Custom Payment Gateway

## Configuration
- Enable features in `assets/config/custom_config.json`
- Set environment variables for build configuration

## Dependencies
- List of additional dependencies and their purposes

## Testing
- How to run custom feature tests
- Integration test procedures
```

### 2. Version Tracking

```dart
class CustomExtensionInfo {
  static const String version = '1.0.0';
  static const String description = 'Custom analytics and payment extensions';
  static const String author = 'Your Company';
  static const List<String> features = [
    'Custom Analytics',
    'Enhanced Product Cards',
    'Custom Payment Gateway',
  ];
  
  static Map<String, dynamic> getInfo() {
    return {
      'version': version,
      'description': description,
      'author': author,
      'features': features,
      'sdkVersion': SDKVersion.current,
    };
  }
}
```

## ⚡ Performance Considerations

### 1. Lazy Loading Custom Features

```dart
class CustomFeatureLoader {
  static final Map<String, Future<dynamic>> _loadedFeatures = {};
  
  static Future<T> loadFeature<T>(String featureName, Future<T> Function() loader) async {
    if (!_loadedFeatures.containsKey(featureName)) {
      _loadedFeatures[featureName] = loader();
    }
    return await _loadedFeatures[featureName] as T;
  }
}

// Usage
final customAnalytics = await CustomFeatureLoader.loadFeature(
  'analytics',
  () => CustomAnalyticsService.initialize(),
);
```

### 2. Memory Management

```dart
class CustomResourceManager {
  static final List<StreamSubscription> _subscriptions = [];
  static final List<Timer> _timers = [];
  
  static void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
  
  static void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }
}
```

## 📞 Support and Community

### Getting Help

- Review SDK documentation and architecture
- Check existing interfaces and extension points
- Follow clean architecture principles
- Test thoroughly with SDK updates

### Contributing Back

- Consider contributing useful extensions back to the SDK
- Document reusable patterns
- Share best practices with the community

---

**Remember**: The goal is to extend functionality while maintaining compatibility with future SDK updates. Always prefer composition over modification, and leverage the provided interfaces and extension points.
