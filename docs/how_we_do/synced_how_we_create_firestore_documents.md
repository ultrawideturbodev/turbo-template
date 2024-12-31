# 📝 How We Create Firestore Documents

This guide explains our approach to creating Firestore documents in our applications, using the shopping lists implementation as a practical example.

## 🤖 GPT Agent Instructions

These instructions help ensure proper setup and implementation of Firestore documents in our application. The goal is to create a consistent, secure, and efficient document structure while following our established patterns.

Before proceeding with any implementation, first check if components already exist:
- Search for existing DTOs in the feature's `dtos` folder
- Check for existing services in the feature's `services` folder
- Look for existing APIs in the feature's `apis` folder
- Verify if similar implementations exist that can be reused

### Initial Confirmation

1. **Confirm Implementation Goals**
   - Verify the Firestore collection structure
   - Confirm if using `CollectionService` or `DocumentService`
   - Check for required relationships with other collections
   - Search for similar existing implementations

2. **State Key Assumptions**
   - We extend either `CollectionService` or `DocumentService` for Firestore operations
   - We use DTOs that implement `WriteableId<String>`
   - We follow a consistent collection structure pattern
   - We implement proper logging using Loglytics
   - We reuse existing components when possible

3. **Request Clarification**
   - Confirm if data belongs in collection or single document
   - Verify collection security rules requirements
   - Check if specific error handling is required
   - Confirm if any specific logging requirements exist
   - Ask if any existing components can be reused 

### Execution Guidelines

1. **Progress Tracking**
   - Set up Firestore collection with security rules
   - Ensure DTO exists implementing `WriteableId<String>`
   - Create service extending appropriate base service
   - Implement UI for document creation
   - Test the implementation

2. **Validation Steps**
   - Verify collection structure
   - Test security rules
   - Check logging output
   - Validate user feedback

3. **Error Handling**
   - Use built-in error handling from base services
   - Show user-friendly feedback
   - Handle edge cases gracefully

### Execution Checklist

Collection Setup:
[ ] Create Firestore collection with proper structure
[ ] Set up security rules for the collection
[ ] Verify DTO implements `WriteableId<String>`
[ ] Create API extending `RmyApi`
[ ] Configure service dependencies

UI Implementation:
[ ] Create UI for document creation (form or direct)
[ ] Add validation feedback (if using form)
[ ] Show loading states
[ ] Display success/error messages
[ ] Add busy state checks before operations when using busy state
[ ] Show error dialogs for caught exceptions

### Important Notes

- Use `CollectionService` for multiple documents
- Use `DocumentService` for single documents
- Base services handle all CRUD operations
- Base services include error handling and logging
- Base services manage local state updates
- Check busy state before starting operations
- Show error dialogs for caught exceptions if needed
- Use `gSetBusy()` and `gSetIdle()` in try/finally blocks for handling busy state

## 🎯 Suggested Approach

- [ ] Set up Firestore collection structure
- [ ] Configure collection security rules
- [ ] Verify DTO and service setup
- [ ] Implement UI for data input
- [ ] Add user feedback mechanisms

## 👨‍🏫 Tutorial

### 1. 📋 Collection Setup

First, set up your Firestore collection structure:

```firestore-security-rules
// In firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /shopping_lists/{shoppingListId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

Ensure your DTO matches the collection structure:

```dart
class ShoppingListDto implements WriteableId<String> {
  @override
  final String id;
  final String title;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String createdBy;
  final String householdId;

  @override
  bool get isLocalDefault => false;

  ShoppingListDto({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.householdId,
  });

  factory ShoppingListDto.defaultValue({
    required String id,
    required String userId,
    required String householdId,
    required String title,
  }) {
    final now = gNow;
    return ShoppingListDto(
      id: id,
      title: title,
      createdAt: now,
      updatedAt: now,
      createdBy: userId,
      householdId: householdId,
    );
  }
}
```

Important notes about the `defaultValue` factory method:

1. **Common Parameters**:
   - `id`: Always use `api.genId` from your service's API
   - `userId`/`createdBy`: Include when the document needs:
     - User-based security rules
     - User-specific filtering
     - Creator tracking
   - Parent IDs (e.g., `householdId`): Include when the document:
     - Belongs to a parent entity
     - Needs parent-based security rules
     - Requires hierarchical data fetching

2. **Timestamps**:
   - Use `final now = gNow` to ensure `createdAt` and `updatedAt` are identical
   - Never pass timestamps from outside the DTO
   - Let the factory method handle timestamp creation

3. **Default Values**:
   - Set sensible defaults for optional fields
   - Initialize collections as empty
   - Set status fields to initial state

Note: The required parameters depend entirely on your document's needs. Not all documents need user IDs or parent IDs. Consider the document's purpose, security requirements, and relationships when deciding which fields to include.

Then in your service:

```dart
Future<FeedbackResponse<DocumentReference>> createShoppingList({
  required String title,
}) async {
  log.debug('Creating shopping list with title: $title');
  
  final shoppingList = ShoppingListDto.defaultValue(
    id: api.genId,
    userId: currentUser.id,
    householdId: currentHousehold.id,
    title: title,
  );
  
  return createDoc(doc: shoppingList);
}
```

### 2. 🛠️ Service Implementation

First, create an API extending `RmyApi`:

```dart
class ShoppingListsApi extends RmyApi<ShoppingListDto> {
  ShoppingListsApi()
      : super(
          firestoreCollection: FirestoreCollection.shoppingLists,
        );
}
```

Then create a service extending either `CollectionService` or `DocumentService`:

- Use `CollectionService` when working with multiple documents (e.g., a list of shopping lists)
- Use `DocumentService` when working with a single document (e.g., user profile)

Example with `CollectionService`:

```dart
class ShoppingListsService extends CollectionService<ShoppingListDto, ShoppingListsApi> {
  ShoppingListsService({
    required super.api,
  });

  Future<FeedbackResponse<DocumentReference>> createShoppingList({
    required String title,
  }) async {
    log.debug('Creating shopping list with title: $title');
    
    final shoppingList = ShoppingListDto.defaultValue(
      id: api.genId,
      userId: currentUser.id,
      householdId: currentHousehold.id,
      title: title,
    );
    
    return createDoc(doc: shoppingList);
  }
}
```

Example with `DocumentService`:

```dart
class UserProfileService extends DocumentService<UserProfileDto, UserProfileApi> {
  UserProfileService({
    required super.api,
  });

  Future<FeedbackResponse<DocumentReference>> createProfile({
    required String name,
  }) async {
    log.debug('Creating user profile with name: $name');
    
    final profile = UserProfileDto.defaultValue(
      id: api.genId,
      userId: currentUser.id,
      name: name,
    );
    
    return createDoc(doc: profile);
  }
}
```

Both base services provide these methods:
- `createDoc` - Creates a new document
- `updateDoc` - Updates an existing document
- `deleteDoc` - Deletes a document
- `upsertDoc` - Creates or updates a document

Key differences:
- `CollectionService` streams a collection of documents
- `DocumentService` streams a single document
- Both expose their values through ValueListenable (docsPerId/doc) for reactive UI updates

### 3. 📱 UI Implementation

There are two common approaches to create documents:

#### A. Form Input

When user input is needed:

```dart
void onCreateShoppingListTapped() {
  _sheetService.showInputSheet(
    sheetBuilder: (context) {
      return TextFormFieldSheet(
        title: strings.createShoppingList,
        message: strings.enterTheNameForTheNewShoppingList,
        saveButtonText: strings.create,
        formFieldLabel: strings.name,
        formFieldHint: strings.shoppingLists,
        onSavedPressed: (context) => _onSaveNewShoppingListPressed(
          context: context,
        ),
        textFormFieldConfig: _shoppingListForm.nameField,
      );
    },
  );
}

Future<void> _onSaveNewShoppingListPressed({
  required BuildContext context,
}) async {
  try {
    if (_shoppingListForm.isValid) {
      final name = _shoppingListForm.nameField.value!;
      final response = await _shoppingListsService.createShoppingList(
        title: name,
      );
      
      if (response.isSuccess) {
        gShowNotification(title: gStrings.createShoppingList);
        context.pop();
      } else {
        gShowResponse(response: response);
      }
    }
  } catch (error, stackTrace) {
    log.error(
      'Error saving shopping list',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
```

#### B. Direct Creation

When creating with default values:

```dart
Future<void> onCreateDefaultListTapped() async {
  try {
    log.debug('Creating default shopping list');
    final response = await _shoppingListsService.createShoppingList(
      title: 'My Shopping List',
    );
    
    if (response.isSuccess) {
      gShowNotification(title: gStrings.createShoppingList);
    } else {
      gShowResponse(response: response);
    }
  } catch (error, stackTrace) {
    log.error(
      'Error creating default shopping list',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
```

## ✅ Checklist

- [ ] Firestore collection is properly set up
- [ ] Security rules are configured correctly
- [ ] Service extends appropriate base service
- [ ] Service is properly registered with dependencies
- [ ] UI provides clear feedback for success/failure
- [ ] Form validation is properly implemented (if applicable)
- [ ] Document creation is properly tested
