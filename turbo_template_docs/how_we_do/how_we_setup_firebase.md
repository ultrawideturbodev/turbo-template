# How We Set Up Firebase

This guide explains how to set up Firebase in our project. For emulator setup and configuration, see [How We Configure Emulators](how_we_configure_emulators.md).

## Prerequisites

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Log in to Firebase:
```bash
firebase login
```

## Project Structure

Our Firebase setup is split into two main parts:
- `turbo_template_firebase/` - Contains Firebase configuration and emulator setup
- `turbo_template_flutter/` - Contains the Flutter app that connects to Firebase

## Setting Up Firebase Project

1. Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
2. Initialize Firebase in the project:
```bash
cd turbo_template_firebase
firebase init
```
   - Select the services you need (Firestore, Auth, Storage, etc.)
   - Choose your project
   - Accept default options for rules files and indexes

## Flutter App Configuration

1. Update dependencies in `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^latest_version
  cloud_firestore: ^latest_version
  firebase_auth: ^latest_version
  # Add other Firebase packages as needed
```

2. Create environment configuration to switch between production and emulators:
```dart
enum Environment {
  production,
  emulators;

  static Environment get current => const String.fromEnvironment('env') == 'emulators' 
    ? Environment.emulators 
    : Environment.production;
    
  static bool get isEmulators => current == Environment.emulators;
}
```

3. Initialize Firebase with the correct configuration:
```dart
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  if (Environment.isEmulators) {
    await connectToEmulators();
  }
}
```

## iOS Configuration

1. Set minimum iOS version in `ios/Podfile`:
```ruby
platform :ios, '13.0'
```

2. Run pod install:
```bash
cd ios
pod install --repo-update
```

## Common Issues

1. **CocoaPods Version Conflicts**: If you encounter CocoaPods version conflicts, try:
```bash
cd ios
pod repo update
pod install --repo-update
```

2. **iOS Build Issues**: If you encounter iOS build issues:
   - Clean the build: `flutter clean`
   - Update pods: `cd ios && pod install`
   - Ensure minimum iOS version is set correctly in Podfile

## Best Practices

1. Always test both production and emulator configurations
2. Use environment-specific configurations for different settings
3. Keep Firebase configuration consistent across the team
4. Document any special setup requirements in the project README

## Related Guides
- [How We Configure Emulators](how_we_configure_emulators.md)
- [How We Run Our App Locally](how_we_run_our_app_locally.md) 