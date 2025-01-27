# View Creation Tutorial

This tutorial will guide you through the process of creating a new view in the application, including all necessary components and integrations.

## Table of Contents
1. [View Creation](#1-view-creation)
2. [View Model Implementation](#2-view-model-implementation)
3. [Arguments Setup](#3-arguments-setup)
4. [Origin Setup](#4-origin-setup)
5. [Locator Registration](#5-locator-registration)
6. [Router Integration](#6-router-integration)

## 1. View Creation

### File Structure
When creating a new view, you'll need to create the following files:
```
lib/features/your_feature/views/your_view/
├── your_view.dart
├── your_view_model.dart
├── your_arguments.dart
└── your_origin.dart
```

### View Implementation
Create your view file (`your_view.dart`):

```dart
class YourView extends StatelessWidget {
  static const path = '/your-view';
  
  const YourView({super.key});
// TODO(GPT-AGENT): wrong
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<YourViewModel>.reactive(
      viewModelBuilder: YourViewModel.locate,
      onViewModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) {
        return Scaffold(
          // Your view implementation
        );
      },
    );
  }
}
```

## 2. View Model Implementation

Create your view model file (`your_view_model.dart`):

```dart
class YourViewModel extends BaseViewModel with Loglytics {
  // TODO(GPT-AGENT): handle arguments
  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  
  static YourViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(YourViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  final _yourService = YourService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise() async {
    super.initialise();
    // Your initialization logic
  }

  @override
  Future<void> dispose() async {
    // Your cleanup logic
    super.dispose();
  }

  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗 HELPERS ------------------------------------------------------------------------------- \\
  // TODO(GPT-AGENT): missing sections again, add all of them
}
```

## 3. Arguments Setup

Create your arguments file (`your_arguments.dart`):

```dart
class YourArguments {
  const YourArguments({
    required this.someId,
    this.optionalData,
  });

  final String someId;
  final String? optionalData;

// TODO(GPT-AGENT): default to id, and ask the suer if its neceassry

  @override
  String toString() => 'YourArguments(someId: $someId, optionalData: $optionalData)';
}
```

## 4. Origin Setup

Create your origin file (`your_origin.dart`):

```dart
enum YourOrigin {
  home,
  settings,
  profile;

  bool get isHome => this == YourOrigin.home;
  bool get isSettings => this == YourOrigin.settings;
  bool get isProfile => this == YourOrigin.profile;
}
```

## 5. Locator Registration

Add your view model to the locator (`lib/core/config/locator.dart`):

```dart
class Locator {
  static void _registerViewModels() {
    // ... existing registrations
    YourViewModel.registerFactory();
  }
}
```

## 6. Router Integration

Add your route to the base router (`lib/core/routing/base_router.dart`):
// TODO(GPT-AGENT): this can be a view or a router
```dart
class BaseRouter {
  static final router = GoRouter(
    routes: [
      // ... existing routes
      GoRoute(
        path: YourView.path,
        name: YourView.path,
        builder: (context, state) {
          final arguments = state.extra as YourArguments;
          final origin = state.queryParameters['origin'] as YourOrigin;
          
          return YourView(
            key: state.pageKey,
            arguments: arguments,
            origin: origin,
          );
        },
      ),
    ],
  );
}
```

## Best Practices

1. **Naming Conventions**
   - Use PascalCase for class names (e.g., `YourView`, `YourViewModel`)
   - Use snake_case for file names (e.g., `your_view.dart`, `your_view_model.dart`)
   - Use kebab-case for routes (e.g., `/your-view`)

2. **Code Organization**
   - Keep related files in the same directory
   - Use the provided section comments in view models
   - Follow the established pattern for locator registration

3. **State Management**
   - Use `BaseViewModel` for consistent state management
   - Implement `initialise()` and `dispose()` methods
   - Use the provided section comments for organizing code

4. **Navigation**
   - Always use the router for navigation
   - Pass required arguments through the router
   - Handle origins appropriately for navigation flow

## Example Usage

Here's how to navigate to your view:

```dart
final arguments = YourArguments(
  someId: 'example-id',
  optionalData: 'optional-data',
);

context.pushNamed(
  YourView.path,
  extra: arguments,
  queryParameters: {'origin': YourOrigin.home.name},
);
```

---

Remember to follow the established patterns and conventions in the codebase. This ensures consistency and maintainability across the application.
