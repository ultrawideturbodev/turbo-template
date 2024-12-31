# 📝 How We Set Up Firebase And Emulators

## Introduction
This guide explains how to set up Firebase in our project and configure Firebase emulators for local development. We'll cover both the Firebase project configuration and Flutter app integration, ensuring a complete setup for both development and production environments.

## 🤖 GPT Agent Instructions
### Initial Confirmation
Before proceeding, I will:
1. **Confirm Implementation Goals**
   - Verify the exact Firebase services needed (Firestore, Auth, Storage, etc.)
   - Confirm target platforms (iOS, Android, Web)
   - Verify development environment requirements
   - Confirm emulator requirements (which services need emulation)
   - Verify port availability for emulators

2. **State Key Assumptions**
   - We will use a mono repo structure with separate Firebase and Flutter projects
   - We will use Firebase CLI and FlutterFire CLI for setup
   - We want to configure Firebase emulators for local development
   - We need environment switching between production and emulators
   - We will follow the standard project structure:
     ```
     project_mono/
     ├── project_firebase/
     │   ├── firebase.json
     │   ├── firestore.rules
     │   ├── storage.rules
     │   ├── functions/
     │   └── scripts/
     │       ├── run_emulators.sh
     │       └── export_emulators_firebase_data.sh
     └── project_flutter/
         ├── lib/
         │   └── core/
         │       ├── config/
         │       │   └── emulator_config.dart
         │       └── utils/
         │           ├── app_setup.dart
         │           └── environment.dart
         └── scripts/
             └── run_emulators.sh
     ```

3. **Request Clarification**
   - Confirm if any assumptions don't match the project needs
   - Ask about any project-specific requirements
   - Verify if any services should be excluded or added
   - Confirm if any additional configuration is needed
   - Verify if any specific emulator ports are required

### Execution Guidelines
1. **Progress Tracking**
   - Create a checklist of all tasks before starting
   - Mark each step as one of: 🔄 In Progress | ✅ Completed | ❌ Failed
   - If a step fails, immediately report the error and wait for user input
   - After each major section, request user confirmation before proceeding

2. **Validation Steps**
   - After each configuration change, verify the file contents
   - For any file modifications, show the changes made
   - Confirm all required dependencies are at compatible versions
   - Test configurations in both emulator and production environments
   - Verify emulator connections for each service

3. **Error Handling**
   - Document any errors encountered
   - Provide the exact error message and context
   - Suggest possible solutions based on the error
   - Wait for user confirmation before applying fixes

### Execution Checklist
Firebase Setup:
- [ ] Install Firebase CLI and FlutterFire CLI
- [ ] Create Firebase project in console
- [ ] Initialize Firebase project with CLI
- [ ] Configure FlutterFire in Flutter app
- [ ] Set up environment configuration

Emulator Setup:
- [ ] Configure emulator ports
- [ ] Create emulator scripts
- [ ] Set up emulator configuration class
- [ ] Configure environment switching

Flutter Configuration:
- [ ] Add Firebase dependencies
- [ ] Initialize Firebase in app
- [ ] Configure development environment
- [ ] Set up emulator connection

Verification:
- [ ] Test Firebase connection
- [ ] Verify emulator setup
- [ ] Check all required services
- [ ] Test environment switching

### Important Notes
- DO NOT proceed to the next section until current section is verified
- Always show the exact commands being run
- For any file changes, show before and after states
- Request explicit user approval for any non-documented steps
- If encountering an undocumented scenario, pause and ask for guidance
- Verify emulator connections before proceeding with development
- Test both production and emulator environments before completing setup

## 🎯 Suggested Approach
1. Set up Firebase Project
   - Install required CLIs (Firebase, FlutterFire)
   - Create and initialize Firebase project
   - Configure basic Firebase services

2. Configure Emulators
   - Set up emulator ports
   - Create emulator scripts
   - Configure environment setup

3. Set up Flutter Integration
   - Configure FlutterFire
   - Set up environment configuration
   - Initialize Firebase with emulators

4. Testing and Verification
   - Test production setup
   - Test emulator setup
   - Verify environment switching

## 👨‍🏫 Tutorial

### 1. 🛠️ Installing Prerequisites
First, we need to install the required CLIs:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Log in to Firebase
firebase login
```

### 2. 🎯 Firebase Project Setup
1. Create a new project in the [Firebase Console][1]

2. Initialize Firebase in your project:
```bash
# Navigate to Firebase directory
cd project_firebase

# Initialize Firebase
firebase init

# Select required features:
# - Firestore
# - Authentication
# - Storage
# - Emulators
```

3. Configure emulator ports in `firebase.json`:
```json
{
  "functions": [
    {
      "source": "functions",
      "codebase": "default",
      "ignore": [
        "node_modules",
        ".git",
        "firebase-debug.log",
        "firebase-debug.*.log"
      ],
      "predeploy": [
        "npm --prefix \"$RESOURCE_DIR\" run lint",
        "npm --prefix \"$RESOURCE_DIR\" run build"
      ]
    }
  ],
  "firestore": {
    "rules": "firestore.rules"
  },
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "auth": {
      "port": 9099
    },
    "functions": {
      "port": 5001
    },
    "firestore": {
      "port": 8080
    },
    "storage": {
      "port": 9199
    },
    "ui": {
      "enabled": true
    }
  }
}
```

### 3. 📱 Flutter Configuration
1. Configure FlutterFire:
```bash
# Navigate to Flutter directory
cd project_flutter

# Run FlutterFire configure
flutterfire configure --project=your-firebase-project
```

2. Add environment configuration (`lib/core/config/environment.dart`):
```dart
abstract class Environment {
  static String? currentVersion;

  static const String _emulators = 'emulators';
  static const String _dev = 'dev';
  static const String _prod = 'prod';

  static const argumentKey = 'env';

  static EnvironmentType get current {
    switch (const String.fromEnvironment(
      Environment.argumentKey,
      defaultValue: _prod,
    )) {
      case _emulators:
        return EnvironmentType.emulators;
      case _dev:
        return EnvironmentType.dev;
      case _prod:
      default:
        return EnvironmentType.prod;
    }
  }

  static bool get isEmulators => current == EnvironmentType.emulators;
}

enum EnvironmentType {
  emulators,
  dev,
  prod;
}
```

3. Create emulator configuration (`lib/core/config/emulator_config.dart`):
```dart
class EmulatorConfig {
  static const _localhost = 'localhost';
  static const _host = '127.0.0.1';

  static void configureEmulators() {
    if (kDebugMode && Environment.isEmulators) {
      const host = kIsWeb ? _localhost : _host;
      FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
      FirebaseStorage.instance.useStorageEmulator(host, 9199);
    }
  }
}
```

4. Initialize Firebase in your app (`lib/core/utils/app_setup.dart`):
```dart
class AppSetup {
  static Future<void> initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    EmulatorConfig.configureEmulators();
    // ... rest of initialization
  }
}
```

### 4. 🔧 Emulator Scripts Setup
1. Create Firebase emulator script (`project_firebase/scripts/run_emulators.sh`):
```bash
#!/bin/bash

# Start Firebase emulators
firebase emulators:start
```

2. Create Flutter emulator script (`project_flutter/scripts/run_emulators.sh`):
```bash
#!/bin/bash

# Navigate to Firebase project and start emulators
cd ../../project_firebase
firebase emulators:start
```

3. Make scripts executable:
```bash
chmod +x project_firebase/scripts/run_emulators.sh
chmod +x project_flutter/scripts/run_emulators.sh
```

### 5. 🧪 Testing the Setup

1. Start the emulators:
```bash
# From project root
cd project_firebase
./scripts/run_emulators.sh
```

2. Run the Flutter app with emulators:
```bash
# In a new terminal
cd project_flutter
flutter run --dart-define=env=emulators
```

3. Verify Firebase connection in logs

4. Test production environment:
```bash
flutter run --dart-define=env=prod
```

## ✅ Checklist
Firebase Setup:
- [ ] Firebase CLI and FlutterFire CLI are installed
- [ ] Firebase project is created and initialized
- [ ] FlutterFire is configured in Flutter app
- [ ] Environment configuration is set up

Emulator Setup:
- [ ] Emulator ports are configured
- [ ] Emulator scripts are created and executable
- [ ] Environment switching is working
- [ ] All services connect to emulators in dev mode

Flutter Integration:
- [ ] Firebase initialization is working
- [ ] App can connect to Firebase services
- [ ] Environment switching works correctly
- [ ] All required services are configured

## 🔍 Common Issues
1. **Emulator Connection Failed**
   - Verify ports are not in use
   - Check host configuration (localhost vs 127.0.0.1)
   - Ensure emulators are running before app launch

2. **Environment Switching Issues**
   - Verify dart-define parameter is correct
   - Check Environment class implementation
   - Ensure EmulatorConfig is called after Firebase initialization

3. **Platform-Specific Issues**
   - iOS: Update minimum version in Podfile
   - Android: Check google-services.json
   - Web: Verify correct host for emulators 

[1]: https://console.firebase.google.com 