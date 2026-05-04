# Product API V1 → V2 Migration Plan

> **Decision:** Direct V2 migration. No V1 support.
> **Status:** In Progress — Phases A & B complete; tests updated. Phases C & D remain.
> **Last Updated:** 2026-04-29

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture Context](#architecture-context)
3. [API Endpoint Changes](#api-endpoint-changes)
4. [Step 1: Update commerce-dart-sdk Models](#step-1-update-commerce-dart-sdk-models)
5. [Step 2: Update ProductService (Endpoints)](#step-2-update-productservice-endpoints)
6. [Step 3: Update Query Parameters](#step-3-update-query-parameters)
7. [Step 4: Update Mappers](#step-4-update-mappers)
8. [Step 5: Update Entities](#step-5-update-entities)
9. [Step 6: Update UseCases](#step-6-update-usecases)
10. [Step 7: Update BLoCs/Cubits](#step-7-update-blocscubits)
11. [Step 8: Update UI Widgets](#step-8-update-ui-widgets)
12. [Step 9: Update Tests](#step-9-update-tests)
13. [Step 10: Cleanup](#step-10-cleanup)
14. [Execution Order](#execution-order)
15. [What Stays Unchanged](#what-stays-unchanged)
16. [V1 Fields With No V2 Equivalent](#v1-fields-with-no-v2-equivalent)
17. [File Reference Index](#file-reference-index)

---

## Overview

Migrate from `/api/v1/products` to `/api/v2/products`. The V2 API restructures the product response:

- Many flat fields move into nested `detail` and `content` objects
- `styledProducts` (inline variants) replaced by separate `/variantchildren` endpoint returning full `Product` objects
- `crossSells` replaced by separate `/relatedproducts` endpoint
- New `/alsopurchased` endpoint
- Inline `pricing` removed — use real-time pricing API (unchanged at `/api/v1/realtimepricing`)
- Inline `availability`/`qtyOnHand` removed — use real-time inventory API (unchanged at `/api/v1/realtimeinventory`)
- New `badges` array on products
- New `properties` extensibility bag on multiple objects
- Several V1-only fields removed entirely
- Several fields renamed (`name` → `productTitle`, `erpNumber` → `productNumber`, etc.)

**Key strategy:** The entity layer is the shield. The mapper translates V2's nested response into the same entity fields the UI expects. Most UI code doesn't change.

```
V2 API Response (new structure) → Updated Models → Updated Mappers → SAME Entities → SAME UI
```

---

## Architecture Context

The codebase follows a 3-layer architecture:

```
commerce-dart-sdk (Models + Services)
    ↓
Mappers (lib/src/features/domain/mapper/)
    ↓
Entities (lib/src/features/domain/entity/)
    ↓
UseCases (lib/src/features/domain/usecases/)
    ↓
BLoCs/Cubits (lib/src/features/presentation/bloc/ & cubit/)
    ↓
UI Widgets (lib/src/features/presentation/screens/ & widget/)
```

**Scale of impact:**
- ~650 files import from `package:optimizely_commerce_api`
- ~34 mapper classes
- ~24 product-related entity classes
- ~80+ UI files display product data
- ~62 test files cover product models
- All model access funneled through mappers — changes propagate cleanly

---

## API Endpoint Changes

### Product Endpoints

| Feature | V1 | V2 |
|---------|----|----|
| Base URL | `/api/v1/products` | `/api/v2/products` |
| Get single product | `GET /api/v1/products/{id}` | `GET /api/v2/products/{id}` |
| Get product collection | `GET /api/v1/products` | `GET /api/v2/products` |
| Cross-sells | `GET /api/v1/products/{id}/crosssells` | **REMOVED** → `GET /api/v2/products/{id}/relatedproducts` |
| Product price | `GET /api/v1/products/{id}/price` | **REMOVED** → use real-time pricing |
| Variant children | N/A (inline via `expand=styledproducts`) | **NEW** `GET /api/v2/products/{id}/variantchildren` |
| Also purchased | N/A | **NEW** `GET /api/v2/products/{id}/alsopurchased` |
| Related products | N/A | **NEW** `GET /api/v2/products/{id}/relatedproducts` |

### Unchanged Endpoints

| Endpoint | Notes |
|----------|-------|
| `POST /api/v1/realtimepricing` | Same API, same request/response |
| `POST /api/v1/realtimeinventory` | Same API, same request/response |
| Cart APIs | Unaffected |
| Order APIs | Unaffected |
| WishList APIs | Unaffected |
| VMI APIs | Unaffected |
| Autocomplete APIs | Unaffected |

### Product Detail Flow Change

**V1 (1 call + real-time):**
```
GET /api/v1/products/{id}?expand=styledproducts,crosssells,pricing,specifications,documents,attributes,htmlcontent,brand
POST /api/v1/realtimepricing
POST /api/v1/realtimeinventory
```

**V2 (3-4 calls + real-time):**
```
GET /api/v2/products/{id}?expand=detail,content,images,specifications,documents,badges
GET /api/v2/products/{id}/variantchildren  (only if isVariantParent)
GET /api/v2/products/{id}/relatedproducts
POST /api/v1/realtimepricing   (unchanged)
POST /api/v1/realtimeinventory (unchanged)
```

---

## Step 1: Update commerce-dart-sdk Models

### 1.1 Update `Product` model

**File:** `commerce-dart-sdk/lib/src/models/product.dart`

**Fields that stay at root level (exist in both V1 and V2):**
```
id, urlSegment, canonicalUrl, smallImagePath, mediumImagePath,
largeImagePath, imageAltText, isDiscontinued, quoteRequired,
minimumOrderQty, isSponsored, trackInventory, configurationType,
canConfigure, canAddToCart, canAddToWishlist, canShowPrice,
canShowUnitOfMeasure, isVariantParent, variantTypeId,
defaultChildProductId, salePriceLabel, cantBuy, allowZeroPricing,
manufacturerItem, packDescription, customerUnitOfMeasure,
unitListPrice, unitListPriceDisplay, priceFacet,
productNumber, customerProductNumber, productTitle,
score, scoreExplanation
```

**New V2 fields to add:**
```dart
String? displayUrl;
ProductDetail? detail;
ProductContent? content;
List<Badge>? badges;
ProductLine? productLine;     // simplified in V2
Brand? brand;                 // simplified in V2
Map<String, dynamic>? properties;
```

**V1-only fields to REMOVE from model** (entity keeps them; mapper populates from V2 nested objects):
```
name, shortDescription, erpNumber, erpDescription, customerName,
basicListPrice, basicSalePrice, basicSaleStartDate, basicSaleEndDate,
pricing (ProductPrice), availability, qtyOnHand, qtyPerShippingPackage,
isConfigured, isFixedConfiguration, isActive, isBeingCompared,
isStyleProductParent, styleParentId, styleTraits, styledProducts,
crossSells, accessories, selectedUnitOfMeasure, selectedUnitOfMeasureDisplay,
productDetailUrl, searchBoost, vendorNumber, currencySymbol,
shippingAmountOverride, handlingAmountOverride, orderLineId, numberInCart,
qtyOrdered, canViewDetails, canEnterQuantity, allowedAddToCart,
productCode, priceCode, sku, upcCode, modelNumber, taxCode1, taxCode2,
taxCategory, shippingClassification, shippingLength, shippingWidth,
shippingHeight, shippingWeight, sortOrder, multipleSaleQty, canBackOrder,
roundingRule, replacementProductId, isHazardousGood, hasMsds,
isSpecialOrder, isGiftCard, isSubscription, allowAnyGiftCardAmount, unspsc,
configurationDto, htmlContent, pageTitle, metaDescription, metaKeywords
```

**Update `fromJson`** to parse V2 response structure (nested `detail`, `content`, `badges`).

### 1.2 Update `ProductDetail` model

**File:** `commerce-dart-sdk/lib/src/models/product_detail.dart`

Add missing V2 fields:
```dart
bool? isSubscription;
ProductSubscriptionDto? subscription;
String? vatCodeId;
```

Update `ConfigSection`:
- Add `id`, `label`, `sortOrder`
- Rename `options` → `sectionOptions`

Update `ConfigSectionOption`:
- `sectionOptionId` → `id`
- Add `name`, `quantity`, `cantBuy`
- Remove `sectionName`, `productName`, `userProductPrice`

### 1.3 ProductContent model — No changes needed

**File:** `commerce-dart-sdk/lib/src/models/product_content.dart`

Already matches V2 structure.

### 1.4 Create `Badge` model (NEW)

**File:** `commerce-dart-sdk/lib/src/models/badge.dart` (create)

```dart
class Badge {
  String? id;
  String? name;
  String? tagName;
  String? badgeStyle;
  int? sortOrder;
  String? badgeType;
  bool? displayOnProductImages;
  bool? displayOnBadgeWidget;
  String? displayText;
  String? textColorHexCode;
  String? badgeColorHexCode;
  String? largeImageBadgePath;
  String? largeImageTextSize;
  String? largeImagePlacement;
  String? otherImageBadgePath;
  String? otherImageTextSize;
  String? otherImagePlacement;
  String? imageAltText;
  String? detailWidgetBadgeSize;
}
```

### 1.5 Update sub-models

| Model | File | Changes |
|-------|------|---------|
| **Brand** | `commerce-dart-sdk/lib/src/models/brand.dart` | Remove `manufacturer`, `externalUrl`, `productListPagePage`, `featuredImagePath`, `featuredImageAltText`, `htmlContent`, `topSellerProducts`. Add `urlSegment`, `logoImageAltText`, `properties` |
| **ProductLine** | `commerce-dart-sdk/lib/src/models/product_line.dart` | Remove `count`, `selected`. Add `properties` |
| **Specification** | `commerce-dart-sdk/lib/src/models/specification.dart` | `specificationId` → `id`. Remove `isActive`, `parentSpecification`, nested `specifications`. Add `htmlContent` |
| **Document** | `commerce-dart-sdk/lib/src/models/document.dart` | Remove `createdOn`, `fileUrl`, `languageId`, `fileTypeString` |
| **ProductUnitOfMeasure** | `commerce-dart-sdk/lib/src/models/product_unit_of_measure.dart` | `productUnitOfMeasureId` → `id`. Remove `availability` |
| **StyleTrait** | `commerce-dart-sdk/lib/src/models/style_trait.dart` | `styleTraitId` → `id`. `styleValues` → `traitValues`. Keep `displayType`, `numberOfSwatchesVisible`, `displayTextWithSwatch` |
| **StyleValue** | `commerce-dart-sdk/lib/src/models/style_value.dart` | `styleTraitValueId` → `id`. Add `swatchType`, `swatchImageValue`, `swatchColorValue`. Remove `styleTraitName` |
| **Pagination** | `commerce-dart-sdk/lib/src/models/pagination.dart` | Add `nextPageToken` |
| **CategoryFacet** | `commerce-dart-sdk/lib/src/models/category_facet.dart` | `subCategoryDtos` → `subCategoryFacets` |

### 1.6 Delete `StyledProduct` model

**File to delete:** `commerce-dart-sdk/lib/src/models/styled_product.dart`

V2 variant children are full `Product` objects. `StyledProduct` is no longer needed.

### 1.7 Update `GetProductCollectionResult`

**File:** `commerce-dart-sdk/lib/src/models/results/get_product_collection_result.dart`

Add:
```dart
String? attributionToken;
PriceRange? priceRange;
```

Update `brandFacets` and `productLineFacets` to include `sortOrder`.

### 1.8 Update or simplify `GetProductResult`

**File:** `commerce-dart-sdk/lib/src/models/results/get_product_result.dart`

V2 returns a single `Product` object directly. Update to match.

---

## Step 2: Update ProductService (Endpoints)

**File:** `commerce-dart-sdk/lib/src/services/product_service.dart`

### 2.1 Change base URL

```dart
// In CommerceAPIConstants
static const String productsUrl = "/api/v2/products"; // was /api/v1/products
```

### 2.2 Update `getProduct()`

Endpoint: `GET /api/v2/products/{productId}`
Response is `Product` directly (or still wrapped in `GetProductResult` depending on V2 envelope).

### 2.3 Update `getProducts()`

Endpoint: `GET /api/v2/products`
Uses `ProductsV2QueryParameters`.

### 2.4 Add `getVariantChildren()` (NEW)

```dart
Future<Result<GetProductCollectionResult, ErrorResponse>> getVariantChildren(
  String productId, {
  VariantChildrenQueryParameters? parameters,
}) {
  // GET /api/v2/products/{productId}/variantchildren
}
```

### 2.5 Add `getRelatedProducts()` (NEW — replaces crosssells)

```dart
Future<Result<GetProductCollectionResult, ErrorResponse>> getRelatedProducts(
  String productId, {
  RelatedProductsQueryParameters? parameters,
}) {
  // GET /api/v2/products/{productId}/relatedproducts
}
```

### 2.6 Add `getAlsoPurchased()` (NEW)

```dart
Future<Result<GetProductCollectionResult, ErrorResponse>> getAlsoPurchased(
  String productId, {
  AlsoPurchasedQueryParameters? parameters,
}) {
  // GET /api/v2/products/{productId}/alsopurchased
}
```

### 2.7 Remove `getProductCrossSells()`

Replaced by `getRelatedProducts()`.

### 2.8 Remove `getProductPrice()`

Use real-time pricing API instead.

### 2.9 Keep real-time pricing/inventory services UNCHANGED

`POST /api/v1/realtimepricing` and `POST /api/v1/realtimeinventory` stay as-is.

---

## Step 3: Update Query Parameters

### 3.1 Update `ProductsQueryParameters`

**File:** `commerce-dart-sdk/lib/src/models/parameters/products_query_parameters.dart`

| Remove | Rename | Add |
|--------|--------|-----|
| `erpNumbers` | `query` → `search` | `minimumPrice` |
| `replaceProducts` | | `maximumPrice` |
| `getAllAttributeFacets` | | `pageToken` |
| `includeAlternateInventory` | | `cartId` |
| `makeBrandUrls` | | `topSellersPersonaIds` |
| `topSellersMaxResults` | | `relevancy` |

Keep: `productIds`, `names`, `extendedNames`, `productNumbers`, `categoryId`, `includeProductsInSubCategories`, `brandIds`, `productLineIds`, `attributeValueIds`, `priceFilters`, `includeSuggestions`, `filter`, `applyPersonalization`, `stockedItemsOnly`, `previouslyPurchasedProducts`, `expand`, `includeAttributes`, `sort`, `page`, `pageSize`, `searchWithin`

### 3.2 Update `ProductQueryParameters`

**File:** `commerce-dart-sdk/lib/src/models/parameters/product_query_parameters.dart`

| Remove | Keep | Add |
|--------|------|-----|
| `replaceProducts` | `productId` | `categoryId` |
| `unitOfMeasure` | `includeAttributes` | |
| `qtyOrdered` | `expand` | |
| `alsoPurchasedMaxResults` | `addToRecentlyViewed` | |
| `includeAlternateInventory` | `applyPersonalization` | |
| `configuration` | | |

### 3.3 Create new query parameter classes (NEW)

**File:** `commerce-dart-sdk/lib/src/models/parameters/variant_children_query_parameters.dart`

```dart
class VariantChildrenQueryParameters {
  String? expand;
  String? includeAttributes;
  String? sort;
  int? page;
  int? pageSize;
  String? pageToken;
}
```

**File:** `commerce-dart-sdk/lib/src/models/parameters/related_products_query_parameters.dart`

```dart
class RelatedProductsQueryParameters {
  String? relationship;
  String? expand;
  String? includeAttributes;
  String? sort;
  int? page;
  int? pageSize;
  String? pageToken;
}
```

**File:** `commerce-dart-sdk/lib/src/models/parameters/also_purchased_query_parameters.dart`

```dart
class AlsoPurchasedQueryParameters {
  String? expand;
  String? includeAttributes;
  String? sort;
  int? page;
  int? pageSize;
  String? pageToken;
}
```

---

## Step 4: Update Mappers

### 4.1 Update `ProductEntityMapper.toEntity()` — THE CRITICAL MAPPER

**File:** `lib/src/features/domain/mapper/product_mapper.dart`

This mapper translates V2's nested response into the flat entity the UI expects. The entity keeps its current fields. The mapper reads from different places:

```dart
static ProductEntity toEntity(Product model) {
  return ProductEntity(
    // --- Fields at root in V2 (direct mapping) ---
    id: model.id,
    productTitle: model.productTitle,
    productNumber: model.productNumber,
    customerProductNumber: model.customerProductNumber,
    urlSegment: model.urlSegment,
    canonicalUrl: model.canonicalUrl,
    displayUrl: model.displayUrl,
    smallImagePath: model.smallImagePath,
    mediumImagePath: model.mediumImagePath,
    largeImagePath: model.largeImagePath,
    imageAltText: model.imageAltText,
    manufacturerItem: model.manufacturerItem,
    packDescription: model.packDescription,
    isDiscontinued: model.isDiscontinued,
    quoteRequired: model.quoteRequired,
    minimumOrderQty: model.minimumOrderQty,
    isSponsored: model.isSponsored,
    trackInventory: model.trackInventory,
    configurationType: model.configurationType,
    canConfigure: model.canConfigure,
    canAddToCart: model.canAddToCart,
    canAddToWishlist: model.canAddToWishlist,
    canShowPrice: model.canShowPrice,
    canShowUnitOfMeasure: model.canShowUnitOfMeasure,
    isVariantParent: model.isVariantParent,
    variantTypeId: model.variantTypeId,
    defaultChildProductId: model.defaultChildProductId,
    salePriceLabel: model.salePriceLabel,
    cantBuy: model.cantBuy,
    allowZeroPricing: model.allowZeroPricing,
    unitListPrice: model.unitListPrice,
    unitListPriceDisplay: model.unitListPriceDisplay,
    priceFacet: model.priceFacet,
    customerUnitOfMeasure: model.customerUnitOfMeasure,
    score: model.score,

    // --- V1 entity fields populated from V2 nested detail ---
    name: model.detail?.name ?? model.productTitle,
    erpNumber: model.productNumber,
    sku: model.detail?.sku,
    upcCode: model.detail?.upcCode,
    modelNumber: model.detail?.modelNumber,
    productCode: model.detail?.productCode,
    priceCode: model.detail?.priceCode,
    unspsc: model.detail?.unspsc,
    sortOrder: model.detail?.sortOrder,
    multipleSaleQty: model.detail?.multipleSaleQty,
    canBackOrder: model.detail?.canBackOrder,
    roundingRule: model.detail?.roundingRule,
    replacementProductId: model.detail?.replacementProductId,
    isHazardousGood: model.detail?.isHazardousGood,
    hasMsds: model.detail?.hasMsds,
    isSpecialOrder: model.detail?.isSpecialOrder,
    isGiftCard: model.detail?.isGiftCard,
    isSubscription: model.detail?.isSubscription,
    allowAnyGiftCardAmount: model.detail?.allowAnyGiftCardAmount,
    taxCode1: model.detail?.taxCode1,
    taxCode2: model.detail?.taxCode2,
    taxCategory: model.detail?.taxCategory,
    shippingClassification: model.detail?.shippingClassification,
    shippingLength: model.detail?.shippingLength,
    shippingWidth: model.detail?.shippingWidth,
    shippingHeight: model.detail?.shippingHeight,
    shippingWeight: model.detail?.shippingWeight,
    configurationDto: model.detail?.configuration != null
        ? LegacyConfigurationEntityMapper().toEntity(model.detail!.configuration!)
        : null,

    // --- V1 entity fields populated from V2 nested content ---
    htmlContent: model.content?.htmlContent,
    pageTitle: model.content?.pageTitle,
    metaDescription: model.content?.metaDescription,
    metaKeywords: model.content?.metaKeywords,

    // --- V1 fields with NO V2 equivalent (null / defaults) ---
    shortDescription: null,
    erpDescription: null,
    customerName: null,
    basicListPrice: null,
    basicSalePrice: null,
    basicSaleStartDate: null,
    basicSaleEndDate: null,
    pricing: null,                    // populated by real-time pricing call
    availability: null,               // populated by real-time inventory call
    qtyOnHand: null,                  // populated by real-time inventory call
    isConfigured: null,               // derive from configurationType
    isFixedConfiguration: null,       // derive from configurationType
    isActive: null,                   // V2 doesn't return inactive products
    isBeingCompared: false,           // UI state
    isStyleProductParent: model.isVariantParent,
    styleParentId: null,
    styleTraits: null,                // use variantTraits instead
    styledProducts: null,             // use /variantchildren endpoint
    crossSells: null,                 // use /relatedproducts endpoint
    accessories: null,                // use /relatedproducts endpoint
    selectedUnitOfMeasure: null,
    selectedUnitOfMeasureDisplay: null,
    productDetailUrl: model.canonicalUrl,
    searchBoost: null,
    vendorNumber: null,
    currencySymbol: null,
    shippingAmountOverride: null,
    handlingAmountOverride: null,
    orderLineId: null,
    numberInCart: null,
    qtyOrdered: null,
    canViewDetails: true,
    canEnterQuantity: true,
    allowedAddToCart: model.canAddToCart,
    requiresRealTimeInventory: null,
    qtyPerShippingPackage: null,

    // --- V2 list fields ---
    variantTraits: model.variantTraits?.map(StyleTraitEntityMapper.toEntity).toList(),
    childTraitValues: model.childTraitValues?.map(ChildTraitValueEntityMapper.toEntity).toList(),
    unitOfMeasures: model.unitOfMeasures?.map(ProductUnitOfMeasureEntityMapper.toEntity).toList(),
    productUnitOfMeasures: model.unitOfMeasures?.map(ProductUnitOfMeasureEntityMapper.toEntity).toList(),
    images: model.images?.map(ProductImageEntityMapper.toEntity).toList(),
    productImages: model.images?.map(ProductImageEntityMapper.toEntity).toList(),
    attributeTypes: model.attributeTypes?.map((e) => AttributeTypeMapper().toEntity(e)).toList(),
    documents: model.documents?.map((e) => DocumentEntityMapper().toEntity(e)).toList(),
    specifications: model.specifications?.map((e) => SpecificationEntityMapper().toEntity(e)).toList(),
    warehouses: model.warehouses?.map((e) => InventoryWarehouseEntityMapper().toEntity(e)).toList(),
    badges: model.badges?.map(BadgeEntityMapper.toEntity).toList(),

    // --- Nested objects ---
    brand: model.brand != null ? BrandEntityMapper.toEntity(model.brand!) : null,
    productLine: model.productLine != null ? ProductLineEntityMapper.toEntity(model.productLine!) : null,
    detail: model.detail != null ? ProductDetailEntityMapper.toEntity(model.detail!) : null,
    content: model.content != null ? ProductContentEntityMapper().toEntity(model.content!) : null,
    scoreExplanation: model.scoreExplanation != null ? ScoreExplanationEntityMapper.toEntity(model.scoreExplanation!) : null,
    productSubscription: model.detail?.subscription != null
        ? ProductSubscriptionEntityMapper.toEntity(model.detail!.subscription!)
        : null,
  );
}
```

### 4.2 Delete `StyledProductEntityMapper`

**File to delete:** `lib/src/features/domain/mapper/styled_prodct_mapper.dart`

Replace all usage with `ProductEntityMapper` for variant children.

### 4.3 Create `BadgeEntityMapper` (NEW)

**File:** `lib/src/features/domain/mapper/badge_mapper.dart` (create)

Standard mapper: `Badge` model → `BadgeEntity`.

### 4.4 Update remaining mappers

| Mapper | File | Changes |
|--------|------|---------|
| **BrandEntityMapper** | `lib/src/features/domain/mapper/brand_mapper.dart` | Remove V1-only fields, add `urlSegment`, `logoImageAltText`, `properties` |
| **ProductLineEntityMapper** | `lib/src/features/domain/mapper/product_line_mapper.dart` | Remove `count`, `selected`. Add `properties` |
| **SpecificationEntityMapper** | `lib/src/features/domain/mapper/specification_mapper.dart` | `specificationId` → `id`. Remove `isActive`, `parentSpecification` |
| **DocumentEntityMapper** | `lib/src/features/domain/mapper/document_mapper.dart` | Remove `createdOn`, `fileUrl`, `languageId`, `fileTypeString` |
| **ProductUnitOfMeasureEntityMapper** | `lib/src/features/domain/mapper/product_unit_of_measure_mapper.dart` | `productUnitOfMeasureId` → `id`. Remove `availability` |
| **StyleTraitEntityMapper** | `lib/src/features/domain/mapper/style_trait_mapper.dart` | `styleTraitId` → `id`. Map `traitValues` → both `styleValues` AND `traitValues` on entity |
| **StyleValueEntityMapper** | `lib/src/features/domain/mapper/style_value_mapper.dart` | `styleTraitValueId` → `id`. Add swatch fields |
| **LegacyConfigurationEntityMapper** | `lib/src/features/domain/mapper/legacy_configuration_mapper.dart` | Update for V2 section/option structure |
| **PaginationEntityMapper** | `lib/src/features/domain/mapper/pagination_entity_mapper.dart` | Add `nextPageToken` |
| **InventoryWarehouseEntityMapper** | `lib/src/features/domain/mapper/inventory_warehouse_mapper.dart` | V2 warehouse simplified: just `id`, `name`, `description`, `qtyAvailable` |
| **ProductDetailEntityMapper** | `lib/src/features/domain/mapper/product_detail_mapper.dart` | Add `isSubscription`, `subscription`, `vatCodeId` |

---

## Step 5: Update Entities

### 5.1 ProductEntity — MINIMAL changes

**File:** `lib/src/features/domain/entity/product_entity.dart`

**Keep ALL existing fields** so UI doesn't break. Only add:
```dart
List<BadgeEntity>? badges;
String? displayUrl;
String? defaultChildProductId;
bool? cantBuy;
```

The mapper handles populating V1-named fields from V2 data. Entity stays backwards-compatible with UI code.

### 5.2 Delete `StyledProductEntity`

**File to delete:** `lib/src/features/domain/entity/styled_product_entity.dart`

Remove the class. All variant references use `ProductEntity` instead.

### 5.3 Create `BadgeEntity` (NEW)

**File:** `lib/src/features/domain/entity/badge_entity.dart` (create)

```dart
class BadgeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? tagName;
  final String? badgeStyle;
  final int? sortOrder;
  final String? badgeType;
  final bool? displayOnProductImages;
  final bool? displayOnBadgeWidget;
  final String? displayText;
  final String? textColorHexCode;
  final String? badgeColorHexCode;
  final String? largeImageBadgePath;
  final String? largeImageTextSize;
  final String? largeImagePlacement;
  final String? otherImageBadgePath;
  final String? otherImageTextSize;
  final String? otherImagePlacement;
  final String? imageAltText;
  final String? detailWidgetBadgeSize;
}
```

### 5.4 Update `BrandEntity`

**File:** `lib/src/features/domain/entity/brand.dart`

Remove: `manufacturer`, `externalUrl`, `topSellerProducts`, `productListPagePage`, `featuredImagePath`, `featuredImageAltText`, `htmlContent`
Add: `urlSegment`, `logoImageAltText`, `properties`

### 5.5 Update `SpecificationEntity`

**File:** `lib/src/features/domain/entity/specification_entity.dart`

Remove: `isActive`, `parentSpecification`, nested `specifications`
`specificationId` → populate from `id`

### 5.6 Update `DocumentEntity`

**File:** `lib/src/features/domain/entity/document._entity.dart`

Remove: `createdOn`, `fileUrl`, `languageId`, `fileTypeString`

### 5.7 Update `ProductUnitOfMeasureEntity`

**File:** `lib/src/features/domain/entity/product_unit_of_measure_entity.dart`

Remove: `availability`
`productUnitOfMeasureId` → populate from `id`

### 5.8 Update `StyleTraitEntity`

**File:** `lib/src/features/domain/entity/style_trait_entity.dart`

Keep BOTH `styleTraitId` and `id`. Mapper populates both from V2's `id`.
Keep BOTH `styleValues` and `traitValues`. Mapper populates both from V2's `traitValues`.
This ensures existing UI code using `styleTraitId` and `styleValues` still works.

### 5.9 Update `StyleValueEntity`

**File:** `lib/src/features/domain/entity/style_value_entity.dart`

Keep `styleTraitValueId` and `id`. Mapper populates both from V2's `id`.
Ensure: `swatchType`, `swatchImageValue`, `swatchColorValue` are present (already on entity).

### 5.10 Cart/Order/WishList Entities — NO CHANGES

These get their data from Cart API, Order API, WishList API — not the Product API. Completely unaffected.

**Files unchanged:**
- `lib/src/features/domain/entity/cart_line_entity.dart`
- `lib/src/features/domain/entity/order/order_line_entity.dart`
- `lib/src/features/domain/entity/wish_list/wish_list_line_entity.dart`
- `lib/src/features/domain/entity/quick_order_item_entity.dart`

---

## Step 6: Update UseCases

### 6.1 `ProductDetailsUseCase` — Major rewrite

**File:** `lib/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart`

**Current flow (1 call):**
```dart
expand: "documents,specifications,styledproducts,htmlcontent,attributes,crosssells,pricing,brand"
```

**New flow (parallel calls):**
```dart
Future<ProductDetailResult> getProductDetails(String productId) async {
  // Call 1: Get product
  final productFuture = productService.getProduct(
    productId,
    parameters: ProductQueryParameters(
      addToRecentlyViewed: true,
      applyPersonalization: true,
      includeAttributes: "IncludeOnProduct",
      expand: "detail,content,images,specifications,documents,badges",
    ),
  );

  // Call 2: Get related products (replaces crosssells)
  final relatedFuture = productService.getRelatedProducts(productId);

  // Call 3: Real-time pricing (unchanged)
  final pricingFuture = realTimePricingService.getProductRealTimePrices(...);

  // Call 4: Real-time inventory (unchanged)
  final inventoryFuture = realTimeInventoryService.getProductRealTimeInventory(...);

  final product = await productFuture;

  // Call 5: Variant children (only if variant parent)
  List<ProductEntity>? variantChildren;
  if (product.isVariantParent == true) {
    final result = await productService.getVariantChildren(productId);
    variantChildren = result.products;
  }

  final related = await relatedFuture;
  final pricing = await pricingFuture;
  final inventory = await inventoryFuture;
}
```

**Image handling update:**
```dart
// Before: styledProduct?.productImages ?? product.productImages
// After:  selectedVariantChild?.productImages ?? product.productImages
```

### 6.2 `ProductDetailsStyleTraitsUseCase` — Rewrite for variant children

**File:** `lib/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart`

```dart
// Before:
bool isProductStyleable() => product.styleTraits?.isNotEmpty ?? false;
// After:
bool isProductStyleable() => product.variantTraits?.isNotEmpty ?? false;

// Before:
StyledProductEntity? getStyledProductBasedOnSelection() {
  // Filter product.styledProducts matching selected styleValues
}
// After:
ProductEntity? getVariantChildBasedOnSelection(List<ProductEntity> variantChildren) {
  for (var child in variantChildren) {
    bool allMatch = true;
    for (var selectedValue in selectedValues) {
      final hasMatch = child.childTraitValues?.any(
        (ctv) => ctv.styleTraitId == selectedValue.styleTraitId
              && ctv.value == selectedValue.value
      ) ?? false;
      if (!hasMatch) { allMatch = false; break; }
    }
    if (allMatch) return child;
  }
  return null;
}

// Before:
getAvailableStyleValues() → reads product.styleTraits[].styleValues
// After:
getAvailableStyleValues() → reads product.variantTraits[].traitValues
```

### 6.3 `ProductDetailsPricingUseCase`

**File:** `lib/src/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart`

- Remove `getProductService().getProductPrice()` calls (endpoint removed)
- All pricing via `getRealTimePricingService()` (unchanged API)
- When variant child selected, pass its `productId` to real-time pricing

### 6.4 `ProductDetailsAddToCartUseCase`

**File:** `lib/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart`

```dart
// Before: use styledProduct.productId or styleParentId
// After:  use selectedVariantChild.id or product.id (if not variant parent)
```

### 6.5 `SearchUseCase`

**File:** `lib/src/features/domain/usecases/search_usecase/search_usecase.dart`

- Update `ProductsQueryParameters`: `query` → `search`, `erpNumbers` → `productNumbers`
- Remove V1-only params

### 6.6 `AddToCartUseCase` (search context)

**File:** `lib/src/features/domain/usecases/search_usecase/add_to_cart_usecase.dart`

```dart
// Before: checks product.styledProducts, product.styleParentId
// After:  checks product.isVariantParent, product.defaultChildProductId
```

### 6.7 `ProductCarouselUseCase`

**File:** `lib/src/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart`

- Update query params
- Cross-sell carousel: use `getRelatedProducts()` instead of expand

### 6.8 `QuickOrderUseCase`

**File:** `lib/src/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart`

- Update expand parameter (remove `styledproducts`, `crosssells`, `pricing`)
- `erpNumber` access already mapped from `productNumber` by mapper

### 6.9 `ProductListFilterUseCase`

**File:** `lib/src/features/domain/usecases/product_list_filter_usecase/product_list_filter_usecase.dart`

- Update query params
- Update facet mapping (V2 facet structure slightly different)

### 6.10 `OrderPricingInventoryUseCase`

**File:** `lib/src/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart`

- Remove `getProductService().getProductPrice()` — use real-time pricing only

### 6.11 `WarehouseInventoryUseCase`

**File:** `lib/src/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart`

- Update expand parameter if needed
- Warehouse data structure simplified in V2

---

## Step 7: Update BLoCs/Cubits

### 7.1 `ProductDetailsBloc` — State change

**File:** `lib/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart`

**Current state:**
```dart
class ProductDetailsState {
  final ProductEntity product;
  final StyledProductEntity? selectedStyledProduct;
}
```

**New state:**
```dart
class ProductDetailsState {
  final ProductEntity product;
  final ProductEntity? selectedVariantChild;       // was StyledProductEntity
  final List<ProductEntity>? variantChildren;       // NEW
  final List<ProductEntity>? relatedProducts;       // NEW (was crossSells on product)
}
```

**Event changes:**
- `StyleTraitSelectedEvent` → logic uses `variantChildren` list instead of `product.styledProducts`
- `FetchProductDetailsEvent` → orchestrate multi-call flow
- `UnitOfMeasuteChangeEvent` → pass selected variant child's productId to pricing

### 7.2 `StyleTraitCubit`

- Use `variantTraits` instead of `styleTraits`
- Emit `ProductEntity` instead of `StyledProductEntity` as selected variant

### 7.3 `AddToCartCubit`

**File:** `lib/src/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart`

- Remove `styleParentId` logic
- Use `isVariantParent` + `defaultChildProductId`

### 7.4 `ProductCarouselCubit`

**File:** `lib/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart`

- Update query params

### 7.5 `SearchProductsCubit`

**File:** `lib/src/features/presentation/cubit/search_products/search_products_cubit.dart`

- Update facet handling if structure changed

### 7.6 `ProductCollectionBloc`

**File:** `lib/src/features/presentation/bloc/product/product_collection_bloc.dart`

- Update query params

---

## Step 8: Update UI Widgets

### 8.1 Widgets that reference `StyledProductEntity` — change to `ProductEntity`

| Widget | File | Change |
|--------|------|--------|
| Product details pricing | `lib/src/features/presentation/screens/product_details/product_details_pricing_widget.dart` | Accept `ProductEntity?` instead of `StyledProductEntity?` for variant |
| Style traits selector | `lib/src/features/presentation/screens/product_details/product_details_style_traits_widget.dart` | Use `variantTraits` instead of `styleTraits` |
| Cross-sell widget | `lib/src/features/presentation/screens/product_details/product_details_cross_sell_widget.dart` | Use related products from bloc state instead of `product.crossSells` |

### 8.2 Widgets that show `shortDescription` from ProductEntity

V2 doesn't return `shortDescription` at the product level. Cart/Order/WishList lines are unaffected (they get `shortDescription` from their own APIs).

Update search grid/list widgets to fallback:
```dart
// Before:
Text(product.shortDescription ?? '')

// After:
Text(product.shortDescription ?? product.productTitle ?? '')
```

**Files:**
- `lib/src/features/presentation/widget/search_product/search_product_grid_item_widget.dart`
- `lib/src/features/presentation/widget/search_product/search_product_list_item_widget.dart`

### 8.3 Extension method updates

**File:** `lib/src/features/domain/extensions/product_extensions.dart`

```dart
String? getProductNumber() {
  // erpNumber is already mapped from productNumber by mapper
  // No change needed if mapper sets erpNumber = productNumber
  return erpNumber;
}
```

**File:** `lib/src/features/domain/extensions/product_pricing_extensions.dart`

No changes needed — works with `ProductPriceEntity` from real-time pricing.

### 8.4 Search grid/list item widgets

**Files:**
- `lib/src/features/presentation/widget/search_product/search_product_grid_item_widget.dart`
- `lib/src/features/presentation/widget/search_product/search_product_list_item_widget.dart`

```dart
// Before: checks styleParentId to determine navigation to parent
// After:  checks isVariantParent or defaultChildProductId
```

### 8.5 Add Badge display widget (NEW, optional)

Create a new widget to display badges on product images/cards. Purely additive — no existing UI breaks without it.

### 8.6 Line item widgets — NO CHANGES

These display data from CartLineEntity / OrderLineEntity / WishListLineEntity which come from their own APIs (Cart, Order, WishList), not the Product API.

**Files unchanged:**
- `lib/src/features/presentation/widget/line_item_widget.dart`
- `lib/src/features/presentation/widget/line_item_title_widget.dart`
- `lib/src/features/presentation/widget/line_item_image_widget.dart`
- `lib/src/features/presentation/widget/line_item_pricing_widgert.dart`
- `lib/src/features/presentation/screens/cart/cart_line_widget.dart`
- `lib/src/features/presentation/screens/quote/quote_line_widget.dart`
- `lib/src/features/presentation/screens/wish_list/wish_list_line_widget.dart`

---

## Step 9: Update Tests

| Test Area | Files | Changes |
|-----------|-------|---------|
| Product mapper tests | `test/features/domain/mapper/product_mapper_test.dart` | Update to use V2 model structure as input |
| Styled product mapper tests | `test/features/domain/mapper/styled_prodct_mapper_test.dart` | DELETE |
| Product price mapper tests | `test/features/domain/mapper/product_price_mapper_test.dart` | No change (real-time pricing unchanged) |
| Sub-model mapper tests | `test/features/domain/mapper/` (25 files) | Update for V2 field structures |
| UseCase tests | Various | Update mocks for multi-call product detail flow |
| Bloc/Cubit tests | Various | Update state expectations (no `StyledProductEntity`) |
| Service tests | Various | Update endpoint URLs, request/response shapes |
| Badge mapper test | NEW | Create test for new badge mapper |

---

## Step 10: Cleanup

1. Delete `StyledProduct` model: `commerce-dart-sdk/lib/src/models/styled_product.dart`
2. Delete `StyledProductEntity`: `lib/src/features/domain/entity/styled_product_entity.dart`
3. Delete `StyledProductEntityMapper`: `lib/src/features/domain/mapper/styled_prodct_mapper.dart`
4. Delete `StyledProductEntityMapper` test: `test/features/domain/mapper/styled_prodct_mapper_test.dart`
5. Delete `getProductCrossSells()` from `ProductService`
6. Delete `getProductPrice()` from `ProductService`
7. Delete `ProductPriceQueryParameter` class
8. Remove V1-only query parameter fields
9. Update `CommerceAPIConstants.productsUrl` to `/api/v2/products`
10. Clean up any remaining `// V1` or `// V2` comments
11. Remove deprecated fields that no longer apply

---

## Execution Order

```
Phase A — SDK Layer (commerce-dart-sdk, no UI impact yet):
  Step 1.1-1.8  (Models)
  Step 2.1-2.9  (Services)
  Step 3.1-3.3  (Query Params)

Phase B — Translation Layer:
  Step 4.1-4.4  (Mappers)
  Step 5.1-5.10 (Entities)

Phase C — Business Logic:
  Step 6.1-6.11 (UseCases)
  Step 7.1-7.6  (BLoCs/Cubits)

Phase D — UI + Polish:
  Step 8.1-8.6  (Widgets)
  Step 9        (Tests)
  Step 10       (Cleanup)
```

---

## What Stays Unchanged

| Component | Reason |
|-----------|--------|
| Real-time pricing API (`POST /api/v1/realtimepricing`) | Same API |
| Real-time inventory API (`POST /api/v1/realtimeinventory`) | Same API |
| `ProductPriceEntity` and pricing display logic | Fed by real-time pricing |
| `AvailabilityEntity` and inventory display logic | Fed by real-time inventory |
| Cart APIs and `CartLineEntity` | Separate API, unaffected |
| Order APIs and `OrderLineEntity` | Separate API, unaffected |
| WishList APIs and `WishListLineEntity` | Separate API, unaffected |
| VMI APIs | Separate API, unaffected |
| Autocomplete APIs | Separate API, unaffected |
| `BreakPriceDto` / `BreakPriceDTOEntity` | Used by real-time pricing |
| `QuickOrderItemEntity` | Wraps ProductEntity, no direct API dependency |

---

## V1 Fields With No V2 Equivalent

These ProductEntity fields exist today but V2 doesn't return them. The mapper sets them to null/defaults:

| Entity Field | UI Usage | V2 Solution |
|-------------|----------|-------------|
| `name` | Product title display | Map from `productTitle` |
| `erpNumber` | `getProductNumber()` extension | Map from `productNumber` |
| `shortDescription` | Search results, product lists | Fall back to `productTitle` in UI |
| `pricing` | Price display everywhere | Populated by real-time pricing call |
| `availability` | Stock status display | Populated by real-time inventory call |
| `qtyOnHand` | Inventory checks | Populated by real-time inventory call |
| `styledProducts` | Variant selection on PDP | Replace with `/variantchildren` endpoint |
| `styleTraits` | Trait selector on PDP | Map from `variantTraits` |
| `styleParentId` | Add-to-cart logic | Use `isVariantParent` + `defaultChildProductId` |
| `crossSells` | Related products carousel | Populated from `/relatedproducts` call |
| `accessories` | Accessories display | Populated from `/relatedproducts` call |
| `isActive` | Wishlist visibility | Default `true` (V2 only returns active products) |
| `isConfigured` | Configuration check | Derive from `configurationType != null` |
| `isFixedConfiguration` | Configuration check | Derive from `configurationType == "Fixed"` |
| `canViewDetails` | Navigation guard | Default `true` |
| `canEnterQuantity` | Qty input visibility | Default `true` |
| `allowedAddToCart` | Cart button state | Map from `canAddToCart` |
| `productDetailUrl` | Navigation | Map from `canonicalUrl` |
| `basicListPrice/SalePrice` | Fallback pricing | `null` — real-time pricing handles this |
| `isBeingCompared` | Compare feature | UI state, `false` |
| `numberInCart` | Cart badge | Cart state, not product data |
| `currencySymbol` | Price formatting | Get from session/settings |
| `customerName` | Customer-specific name | Not in V2 |
| `erpDescription` | ERP description | Not in V2 |
| `vendorNumber` | Vendor reference | Not in V2 |
| `searchBoost` | Search relevance boost | Not in V2 (use `score` instead) |
| `selectedUnitOfMeasure` | UOM selection state | UI state |
| `shippingAmountOverride` | Shipping override | Not in V2 |
| `handlingAmountOverride` | Handling override | Not in V2 |
| `qtyPerShippingPackage` | Shipping calc | Not in V2 |
| `orderLineId` | Order line ref | Cart/order state |
| `qtyOrdered` | Quantity ordered | Cart/order state |
| `requiresRealTimeInventory` | Inventory flag | From real-time inventory API |

---

## File Reference Index

### Models (commerce-dart-sdk)
- `commerce-dart-sdk/lib/src/models/product.dart` — Main product model
- `commerce-dart-sdk/lib/src/models/product_detail.dart` — Product detail sub-model
- `commerce-dart-sdk/lib/src/models/product_content.dart` — Product content sub-model
- `commerce-dart-sdk/lib/src/models/product_image.dart` — Product image
- `commerce-dart-sdk/lib/src/models/product_price.dart` — Product price (real-time)
- `commerce-dart-sdk/lib/src/models/product_unit_of_measure.dart` — UOM
- `commerce-dart-sdk/lib/src/models/styled_product.dart` — **DELETE**
- `commerce-dart-sdk/lib/src/models/style_trait.dart` — Style/variant trait
- `commerce-dart-sdk/lib/src/models/style_value.dart` — Style/variant value
- `commerce-dart-sdk/lib/src/models/child_trait_value.dart` — Child trait value
- `commerce-dart-sdk/lib/src/models/brand.dart` — Brand
- `commerce-dart-sdk/lib/src/models/product_line.dart` — Product line
- `commerce-dart-sdk/lib/src/models/attribute_type.dart` — Attribute type
- `commerce-dart-sdk/lib/src/models/attribute_value.dart` — Attribute value
- `commerce-dart-sdk/lib/src/models/specification.dart` — Specification
- `commerce-dart-sdk/lib/src/models/document.dart` — Document
- `commerce-dart-sdk/lib/src/models/availability.dart` — Availability
- `commerce-dart-sdk/lib/src/models/warehouse.dart` — Warehouse
- `commerce-dart-sdk/lib/src/models/inventory_warehouse.dart` — Inventory warehouse
- `commerce-dart-sdk/lib/src/models/legacy_configuration.dart` — Configuration
- `commerce-dart-sdk/lib/src/models/pagination.dart` — Pagination
- `commerce-dart-sdk/lib/src/models/category_facet.dart` — Category facet
- `commerce-dart-sdk/lib/src/models/generic_facet.dart` — Generic facet
- `commerce-dart-sdk/lib/src/models/price_range.dart` — Price range
- `commerce-dart-sdk/lib/src/models/price_facet.dart` — Price facet
- `commerce-dart-sdk/lib/src/models/suggestion_dto.dart` — Search suggestion
- `commerce-dart-sdk/lib/src/models/break_price_dto.dart` — Break price
- `commerce-dart-sdk/lib/src/models/score_explanation.dart` — Score explanation
- `commerce-dart-sdk/lib/src/models/results/get_product_collection_result.dart` — Collection result
- `commerce-dart-sdk/lib/src/models/results/get_product_result.dart` — Single product result
- `commerce-dart-sdk/lib/src/models/parameters/product_query_parameters.dart` — Single product params
- `commerce-dart-sdk/lib/src/models/parameters/products_query_parameters.dart` — Collection params
- `commerce-dart-sdk/lib/src/models/parameters/product_price_query_parameter.dart` — **DELETE**
- `commerce-dart-sdk/lib/src/services/product_service.dart` — Product service

### Entities
- `lib/src/features/domain/entity/product_entity.dart`
- `lib/src/features/domain/entity/styled_product_entity.dart` — **DELETE**
- `lib/src/features/domain/entity/product_detail_entity.dart`
- `lib/src/features/domain/entity/product_content_entity.dart`
- `lib/src/features/domain/entity/product_image_entity.dart`
- `lib/src/features/domain/entity/product_price_entity.dart`
- `lib/src/features/domain/entity/product_unit_of_measure_entity.dart`
- `lib/src/features/domain/entity/product_line_entity.dart`
- `lib/src/features/domain/entity/style_trait_entity.dart`
- `lib/src/features/domain/entity/style_value_entity.dart`
- `lib/src/features/domain/entity/child_trait_value_entity.dart`
- `lib/src/features/domain/entity/attribute_type_entity.dart`
- `lib/src/features/domain/entity/attribute_value_entity.dart`
- `lib/src/features/domain/entity/specification_entity.dart`
- `lib/src/features/domain/entity/document._entity.dart`
- `lib/src/features/domain/entity/brand.dart`
- `lib/src/features/domain/entity/availability_entity.dart`
- `lib/src/features/domain/entity/warehouse_entity.dart`
- `lib/src/features/domain/entity/inventory_warehouse_entity.dart`
- `lib/src/features/domain/entity/legacy_configuration_entity.dart`
- `lib/src/features/domain/entity/break_price_entity.dart`
- `lib/src/features/domain/entity/score_explanation_entity.dart`
- `lib/src/features/domain/entity/pagination_entity.dart`
- `lib/src/features/domain/entity/cart_line_entity.dart`
- `lib/src/features/domain/entity/quick_order_item_entity.dart`

### Mappers
- `lib/src/features/domain/mapper/product_mapper.dart`
- `lib/src/features/domain/mapper/styled_prodct_mapper.dart` — **DELETE**
- `lib/src/features/domain/mapper/product_detail_mapper.dart`
- `lib/src/features/domain/mapper/product_content_mapper.dart`
- `lib/src/features/domain/mapper/product_image_mapper.dart`
- `lib/src/features/domain/mapper/product_price_mapper.dart`
- `lib/src/features/domain/mapper/product_unit_of_measure_mapper.dart`
- `lib/src/features/domain/mapper/product_line_mapper.dart`
- `lib/src/features/domain/mapper/style_trait_mapper.dart`
- `lib/src/features/domain/mapper/style_value_mapper.dart`
- `lib/src/features/domain/mapper/child_trait_value_mapper.dart`
- `lib/src/features/domain/mapper/attribute_type_mapper.dart`
- `lib/src/features/domain/mapper/attribute_value_mapper.dart`
- `lib/src/features/domain/mapper/specification_mapper.dart`
- `lib/src/features/domain/mapper/document_mapper.dart`
- `lib/src/features/domain/mapper/brand_mapper.dart`
- `lib/src/features/domain/mapper/availability_mapper.dart`
- `lib/src/features/domain/mapper/warehouse_mapper.dart`
- `lib/src/features/domain/mapper/inventory_warehouse_mapper.dart`
- `lib/src/features/domain/mapper/legacy_configuration_mapper.dart`
- `lib/src/features/domain/mapper/break_price_mapper.dart`
- `lib/src/features/domain/mapper/score_explanation_mapper.dart`
- `lib/src/features/domain/mapper/pagination_entity_mapper.dart`
- `lib/src/features/domain/mapper/sort_option_entity_mapper.dart`

### UseCases
- `lib/src/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart`
- `lib/src/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart`
- `lib/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart`
- `lib/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart`
- `lib/src/features/domain/usecases/porduct_details_usecase/warehouse_inventory_usecase.dart`
- `lib/src/features/domain/usecases/search_usecase/search_usecase.dart`
- `lib/src/features/domain/usecases/search_usecase/add_to_cart_usecase.dart`
- `lib/src/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart`
- `lib/src/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart`
- `lib/src/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart`
- `lib/src/features/domain/usecases/product_list_filter_usecase/product_list_filter_usecase.dart`
- `lib/src/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart`

### BLoCs/Cubits
- `lib/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart`
- `lib/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart`
- `lib/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart`
- `lib/src/features/presentation/bloc/product/product_collection_bloc.dart`
- `lib/src/features/presentation/bloc/search/search/search_bloc.dart`
- `lib/src/features/presentation/bloc/quick_order/auto_complete/quick_order_auto_complete_bloc.dart`
- `lib/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart`
- `lib/src/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart`
- `lib/src/features/presentation/cubit/search_products/search_products_cubit.dart`
- `lib/src/features/presentation/cubit/product_list_filter/product_list_filter_cubit.dart`

### UI Widgets (product-specific changes needed)
- `lib/src/features/presentation/screens/product_details/product_details.dart`
- `lib/src/features/presentation/screens/product_details/product_details_pricing_widget.dart`
- `lib/src/features/presentation/screens/product_details/product_details_style_traits_widget.dart`
- `lib/src/features/presentation/screens/product_details/product_details_cross_sell_widget.dart`
- `lib/src/features/presentation/screens/product_details/product_details_general_widget.dart`
- `lib/src/features/presentation/widget/search_product/search_product_grid_item_widget.dart`
- `lib/src/features/presentation/widget/search_product/search_product_list_item_widget.dart`
- `lib/src/features/presentation/widget/product_carousel_item_widget.dart`
- `lib/src/features/presentation/widget/style_trait_select_widget.dart`
- `lib/src/features/presentation/widget/style_trait_widget_items.dart`

### Extensions
- `lib/src/features/domain/extensions/product_extensions.dart`
- `lib/src/features/domain/extensions/product_pricing_extensions.dart`
- `lib/src/features/domain/extensions/cart_line_extentions.dart`
- `lib/src/features/domain/extensions/wish_list_line_extensions.dart`

### Tests
- `test/features/domain/mapper/product_mapper_test.dart`
- `test/features/domain/mapper/styled_prodct_mapper_test.dart` — **DELETE**
- `test/features/domain/mapper/product_price_mapper_test.dart`
- `test/features/domain/mapper/product_image_mapper_test.dart`
- `test/features/domain/mapper/product_content_mapper_test.dart`
- `test/features/domain/mapper/product_detail_mapper_test.dart`
- `test/features/domain/mapper/style_trait_mapper_test.dart`
- `test/features/domain/mapper/style_value_mapper_test.dart`
- `test/features/domain/mapper/child_trait_value_mapper_test.dart`
- `test/features/domain/mapper/product_unit_of_measure_mapper_test.dart`
- `test/features/domain/mapper/attribute_type_mapper_test.dart`
- `test/features/domain/mapper/attribute_value_mapper_test.dart`
- `test/features/domain/mapper/specification_mapper_test.dart`
- `test/features/domain/mapper/document_mapper_test.dart`
- `test/features/domain/mapper/legacy_configuration_mapper_test.dart`
- `test/features/domain/mapper/brand_mapper_test.dart`
- `test/features/domain/mapper/product_line_mapper_test.dart`
- `test/features/domain/mapper/availability_mapper_test.dart`
- `test/features/domain/mapper/inventory_warehouse_mapper_test.dart`
- `test/features/domain/mapper/warehouse_mapper_test.dart`
- `test/features/domain/mapper/score_explanation_mapper_test.dart`
- `test/features/domain/mapper/field_score_detailed_entity_test.dart`
- `test/features/domain/mapper/break_price_mapper_test.dart`
- `test/features/domain/mapper/pagination_entity_mapper_test.dart`
- `test/features/domain/mapper/sort_option_entity_mapper_test.dart`
