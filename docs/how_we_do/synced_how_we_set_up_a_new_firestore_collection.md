# 🔥 How We Set Up A New Firestore Collection

## 📝 Introduction
We use a structured approach to communicate with Firestore through a layered architecture (API, Service) as demonstrated in our shopping list feature implementation.

## 🎯 Why This Approach?
- Type-safe data handling through DTOs (e.g., `ShoppingListDto`)
- Clear separation between data access (`ShoppingListsApi`) and business logic (`ShoppingListsService`)
- Consistent dependency injection using GetIt
- Proper sub-collection handling within households

## 🔄 Exact Process In Steps

### 1. Create Collection and DTOs
Example from `shopping_list_dto.dart` and `firestore_collection.dart`:
```dart
// First add to FirestoreCollection enum
enum FirestoreCollection {
  users,
  households,
  shoppingLists, // New collection
  ;
}

// Then create the DTO
@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ShoppingListDto extends WriteableId<String> {
  ShoppingListDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.title,
  });

  @override
  final String id;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String createdBy;
  final String title;
}
```

### 2. Update Security Rules
Example from `firestore.rules`:
```
match /shoppingLists/{documentId} {
  allow create: if hasAuth() && 
    request.auth.uid == request.resource.data.createdBy && 
    isHouseholdMember(request.resource.data.householdId);
  allow read: if hasAuth() && 
    isHouseholdMember(resource.data.householdId);
  allow update: if hasAuth() && 
    isHouseholdMember(resource.data.householdId);
  allow delete: if hasAuth() && 
    isHouseholdMember(resource.data.householdId);
}
```

### 3. Implement Collection Service
Example from `shopping_lists_service.dart`:
```dart
class ShoppingListsService extends CollectionService<ShoppingListDto, ShoppingListsApi> {
  ShoppingListsService() : super(api: ShoppingListsApi.locate);

  @override
  Stream<List<ShoppingListDto>> Function(User user) get stream =>
      (user) => api.findStreamWithConverter();
}
```

### 4. Add to Locator
Example from `locator.dart`:
```dart
class Locator {
  static void _registerFactories() {
    ShoppingListsApi.registerFactory();
  }

  static void _registerLazySingletons() {
    ShoppingListsService.registerLazySingleton();
  }
}
```

## 📌 Usage Example
Example from `shopping_list_view_model.dart`:
```dart
class ShoppingListViewModel extends BaseViewModel {
  // Access the service through the locator
  final _shoppingListsService = ShoppingListsService.locate;
}
```

## 📌 Summary
Our shopping list implementation follows a strict chronological order: starting with collection and DTO setup, securing access through rules, implementing the service layer, and registering dependencies. This structured approach ensures proper data handling and access control at every level. 
