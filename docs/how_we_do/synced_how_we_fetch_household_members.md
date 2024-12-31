# 🏠 How We Fetch Household Members

This guide explains how we manage and fetch household members in Roomy.

## 🎯 What Problem Are We Solving

In Roomy users can be part of a household. We need to:
- 👥 Keep track of who's in the household
- 🔄 Update the UI when members change
- 🔍 Make sure all parts of the app see the same member data
- ⚡️ Handle this efficiently without unnecessary database calls

## 🧩 Core Components Explained

### 🏗️ HouseholdService
This service manages everything related to households. It extends `DocumentService` which gives us common Firestore operations. Think of it as the brain that coordinates all household-related actions.

### 🔌 ProfilesApi
This is our gateway to user profile data in Firestore. It handles all the database operations for user profiles. We use this to fetch the actual profile data of household members.

### 📱 Informer
This is our custom state management solution. Similar to Flutter's `ValueNotifier` but with extra features:
- 🔄 Can force updates even if values are the same
- 🛠️ Has helper methods for updating values
- ⚡️ Integrates well with Flutter's widget rebuilding system

## 🔄 How The Flow Works

1. Something triggers a household update (user joins/leaves/etc.)
2. The `afterLocalNotifyUpdate` callback in `HouseholdService` runs automatically
3. This callback does two things:
   ```dart
   if (householdDto != null) {
     // Fetch fresh profile data for all members
     final members = await _profilesApi.findHouseholdMembers(householdDto: householdDto);
     _householdMembers.update(members);
   } else {
     // Clear the list if there's no household
     _householdMembers.update([]);
   }
   ```

## 🧠 State Management Deep Dive

### 📡 What's a ValueListenable

`ValueListenable` is a Flutter concept that lets widgets listen to value changes. When the value changes any listening widgets rebuild automatically.

```dart
// This getter exposes our member list as a ValueListenable
ValueListenable<List<UserProfileDto>> get householdMembers => _householdMembers;

// In a widget you can use it like this:
ValueListenableBuilder<List<UserProfileDto>>(
  valueListenable: householdService.householdMembers,
  builder: (context, members, child) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) => MemberTile(member: members[index]),
    );
  },
)
```

## 💡 Why We Do It This Way

### 🔄 Automatic Updates
- When the household changes the UI updates automatically
- No need to manually refresh or poll for changes
- Widgets only rebuild when needed

### 🏗️ Clean Architecture
- Services handle business logic
- APIs handle data operations
- UI just needs to listen to changes

### 🚀 Memory Efficient
- One source of truth for member data
- No duplicate member lists
- Garbage collection can clean up when listeners are disposed

### 🛠️ Developer Friendly
- Easy to debug (just watch the Informer value)
- Predictable data flow
- Less chance of race conditions

## ⚠️ Common Gotchas

1. 📦 Remember that `householdMembers` is a list that updates as one unit
2. 👀 Always use `ValueListenableBuilder` to listen to changes
3. 🗑️ The list is cleared when there's no household
4. ⏱️ Updates are automatic but still asynchronous
