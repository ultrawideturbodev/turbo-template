# 🔄 How We Update Firestore Fields

## 🎯 Introduction
Updating Firestore fields requires careful consideration to maintain data integrity and optimize performance. Our approach ensures atomic updates while providing real-time local updates for a seamless user experience.

## 🚀 Process In Steps

### 1️⃣ User Input Collection
User input can come from various sources like `FormFieldConfig` text fields date pickers dropdowns or any other input method that fits your needs.

### 2️⃣ Update Request Object
Create a dedicated request object for field updates:
```dart
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UpdateHouseholdDtoRequest extends Writeable {
  UpdateHouseholdDtoRequest({
    required this.name,
  });

  final String name;
}
```

Key points:
- Use `includeIfNull: false` to only send fields that are actually updated
- Field names must match the DTO (`HouseholdDto`) for Firestore merge to work
- Extend `Writeable` for JSON serialization support

### 3️⃣ Service Layer Update
Using `CollectionService` or `DocumentService` for updates:
```dart
Future<FeedbackResponse<DocumentReference>> updateHouseholdName({
  required String householdId,
  required String name,
}) async {
  final household = findById(householdId);
  final updatedHousehold = household.copyWith(name: name);
  
  return updateDoc(
    doc: updatedHousehold,
    remoteUpdateRequestBuilder: (doc) => UpdateHouseholdDtoRequest(
      name: name,
    ),
  );
}
```

Benefits:
- Immediate local state update through `updateDoc`
- Optimistic UI updates while waiting for server response
- Specific field updates using `remoteUpdateRequestBuilder`
- Automatic error handling and response management

### 4️⃣ Response Handling
```dart
final response = await updateHouseholdName(
  householdId: 'id',
  name: nameField.value!,
);

if (response.isSuccess) {
  // Show success feedback
} else {
  // Show error feedback
}
``` 