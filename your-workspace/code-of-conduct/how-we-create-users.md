---
document_type: code of conduct
goal: define structure and process for creating user documents
gpt_action: follow these steps when implementing user creation functionality
---

# 🔍 Initial Research

1. [[You]] [[verify existing components]]
   1. [[verify existing components]]
      1. Check for UserDto in auth's `dtos` folder
      2. Verify UserService in auth's `services` folder
      3. Look for UsersApi in auth's `apis` folder
      4. Check for existing user-related implementations

2. [[You]] [[confirm implementation details]]
   1. [[confirm implementation details]]
      1. Verify Firestore users collection structure
      2. Confirm if using `TurboDocumentService`
      3. Check required relationships with other collections (profiles, usernames)
      4. Search for similar user-related implementations

3. [[You]] [[state assumptions]]
   1. [[state assumptions]]
      1. We extend `TurboDocumentService` for user management
      2. We use UserDto implementing `TurboWriteableId<String>`
      3. We follow consistent collection structure
      4. We implement proper logging using Loglytics
      5. We handle user creation after Firebase Auth registration

# 🛠️ Implementation

1. [[You]] [[setup user collection]]
   1. [[setup user collection]]
      1. Create Firestore users collection with proper structure
      2. Set up security rules:
```firestore-security-rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

2. [[You]] [[implement user creation]]
   1. [[implement user creation]]
      1. Create UserService method:
```dart
Future<TurboResponse> createUser({
  required String userId,
  required String email,
  DateTime? acceptedPrivacyAndTermsAt,
  DateTime? trialEnd,
}) async {
  final userDto = UserDto.defaultValue(
    userId: userId,
    email: email,
    acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
    trialEnd: trialEnd,
  );
  return api.createDoc(
    id: userId,
    writeable: CreateUserRequest(
      userDto: userDto,
    ),
  );
}
```

3. [[You]] [[handle user creation flow]]
   1. [[handle user creation flow]]
      1. After Firebase Auth registration:
```dart
final authResponse = await _emailService.register(
  email: email,
  password: password,
);

if (authResponse.isSuccess) {
  final userId = authResponse.result!.uid;
  final createUserResponse = await _userService.createUser(
    userId: userId,
    email: email,
  );
  
  if (createUserResponse.isSuccess) {
    // Handle next steps (profile creation, etc.)
  } else {
    // Handle user creation failure
  }
}
```

# ✅ Verification

1. [[You]] [[verify implementation]]
   1. [[verify implementation]]
      1. User collection properly set up
      2. Security rules configured correctly
      3. UserService extends TurboDocumentService
      4. Service registered with dependencies
      5. User creation properly integrated with auth flow
      6. Error handling implemented
      7. User document creation tested

2. [[You]] [[verify user data]]
   1. [[verify user data]]
      1. Check required fields are present:
         - id (from Firebase Auth)
         - email
         - createdAt
         - updatedAt
         - acceptedPrivacyAndTermsAt (if applicable)
         - trialEnd (if applicable)
         - userLevel
         - tags
      2. Verify optional fields handling:
         - addressCity
         - addressPostalCode
         - addressStreet
         - addressStreetNumber
         - addressStreetNumberAddition
         - phone
         - geoPoint 

# 1. Issue(s)
- 1.1 · User Creation Process
    - 1.1.1 · Need a standardized process for creating user documents in Firestore after Firebase Auth registration
    - 1.1.2 · Need proper security rules and data validation for user documents
    - 1.1.3 · Need to handle relationships with other collections (profiles, usernames)

# 2. Solution(s)
- [1.1.1] · Need a standardized process for creating user documents in Firestore after Firebase Auth registration
    - 2.1 · Implement User Document Creation
        - 2.1.1 · Create UserService method for document creation
        - 2.1.2 · Integrate with Firebase Auth registration flow
    - 2.2 · Setup Data Structure
        - 2.2.1 · Define required and optional user fields
        - 2.2.2 · Implement proper DTO and request classes
    - 2.3 · Configure Security
        - 2.3.1 · Set up proper Firestore security rules
        - 2.3.2 · Implement error handling and validation

# 3. Atomic Development Steps
- [2.1.1] · Create UserService method for document creation
    - 3.1 · Implement createUser method
        - how · Add method to UserService:
```dart
Future<TurboResponse> createUser({
  required String userId,
  required String email,
  DateTime? acceptedPrivacyAndTermsAt,
  DateTime? trialEnd,
}) async {
  final userDto = UserDto.defaultValue(
    userId: userId,
    email: email,
    acceptedPrivacyAndTermsAt: acceptedPrivacyAndTermsAt,
    trialEnd: trialEnd,
  );
  return api.createDoc(
    id: userId,
    writeable: CreateUserRequest(
      userDto: userDto,
    ),
  );
}
```
    - 3.2 · Configure security rules
        - how · Add to Firestore rules:
```firestore-security-rules
match /users/{userId} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && request.auth.uid == userId;
}
```
    - 3.3 · Integrate with auth flow
        - how · Implement in registration:
```dart
final authResponse = await _emailService.register(
  email: email,
  password: password,
);

if (authResponse.isSuccess) {
  final userId = authResponse.result!.uid;
  final createUserResponse = await _userService.createUser(
    userId: userId,
    email: email,
  );
  
  if (createUserResponse.isSuccess) {
    // Handle next steps (profile creation, etc.)
  } else {
    // Handle user creation failure
  }
}
```
    - 3.4 · Verify implementation
        - how · Check:
          - User collection setup
          - Security rules
          - Service registration
          - Auth flow integration
          - Error handling
          - Required fields:
            - id (from Firebase Auth)
            - email
            - createdAt
            - updatedAt
            - acceptedPrivacyAndTermsAt (if applicable)
            - trialEnd (if applicable)
            - userLevel
            - tags
          - Optional fields:
            - addressCity
            - addressPostalCode
            - addressStreet
            - addressStreetNumber
            - addressStreetNumberAddition
            - phone
            - geoPoint
