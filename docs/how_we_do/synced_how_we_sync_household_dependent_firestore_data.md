# 📝 Introduction
Household-dependent Firestore data refers to data that is associated with a specific household and should only be accessible to members of that household. This document explains how we handle syncing this data efficiently and securely using our custom sync services.

# 🎯 Suggested Approach
- [ ] Create a DTO that includes householdId field
- [ ] Extend BeforeHouseholdSyncService, HouseholdSyncService, or AfterHouseholdSyncService based on data processing needs
- [ ] Implement householdStream method to filter data by householdId
- [ ] Add security rules to verify household membership
- [ ] Clean up data when household changes

# 👨‍🏫 Tutorial

### 1. 📋 Create DTO with Household ID
```dart
@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ShoppingListItemDto extends WriteableId<String> {
  ShoppingListItemDto({
    required this.id,
    required this.householdId,
    // ... other fields
  });

  final String householdId;
  // ... other fields
}
```

### 2. 🔄 Choose Sync Service Base
```dart
// Use BeforeHouseholdSyncService when you need to process data before notifying listeners
class ShoppingListItemsService extends BeforeHouseholdSyncService<ShoppingListItemDto, ShoppingListItemsApi> {
  // ...
}

// Use HouseholdSyncService when no preprocessing is needed
class ShoppingListsService extends HouseholdSyncService<ShoppingListDto, ShoppingListsApi> {
  // ...
}

// Use AfterHouseholdSyncService when you need to process data after notifying listeners
class HouseholdInvitesService extends AfterHouseholdSyncService<HouseholdInviteDto, HouseholdInvitesApi> {
  // ...
}
```

### 3. 🌊 Implement Household Stream
```dart
@override
FutureOr<Stream<List<ShoppingListItemDto?>>> householdStream(User user, String? householdId) {
  if (householdId == null) return Stream.value(null);
  return api.findStreamByQueryWithConverter(
    whereDescription: 'householdId is $householdId',
    collectionReferenceQuery: (collectionReference) => 
      collectionReference.where(kKeysHouseholdId, isEqualTo: householdId),
  );
}
```

### 4. 🔒 Add Security Rules
```
match /shoppingLists/{documentId} {
  allow create: if hasAuth() && 
    request.auth.uid == request.resource.data.createdBy && 
    isHouseholdMember(request.resource.data.householdId);
  allow read, update, delete: if hasAuth() && 
    isHouseholdMember(resource.data.householdId);
}
```

### 5. 📦 Handle Household Changes
The base service automatically handles:
- Cleaning up old subscriptions
- Resetting data when household changes
- Resubscribing to new household data

# ✅ Checklist
- [ ] DTO includes householdId field
- [ ] Service extends correct base class (BeforeHouseholdSyncService, HouseholdSyncService, or AfterHouseholdSyncService)
- [ ] householdStream method implemented with proper filtering
- [ ] Security rules include household membership checks
- [ ] No memory leaks (base service handles cleanup)
- [ ] Proper error handling in place
