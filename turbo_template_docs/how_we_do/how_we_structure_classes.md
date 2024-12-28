# 🏗️ How We Structure Classes

## 📖 Overview
We use a consistent class structure with clearly marked sections to make our code more maintainable and navigable. Each section is marked with a distinct emoji and ASCII art divider, making it easy to quickly jump to specific parts of a class.

## 🔍 Section Structure

```dart
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
// For dependency injection and service location
- Static getters/methods for dependency injection
- Factory registration methods

// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// For injected dependencies and services
- Final service instances
- API instances
- Other dependencies

// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// For initialization and cleanup
- initState/dispose overrides
- Custom initialization methods
- Cleanup methods

// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// For event listeners and subscriptions
- Stream subscriptions
- Event handlers
- Callback methods

// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// For method overrides from parent classes
- Required overrides
- Optional overrides
- Interface implementations

// 🎩 STATE --------------------------------------------------------------------------------- \\
// For state management
- ValueNotifiers
- StateNotifiers
- Form controllers
- Local state variables

// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// For technical utilities
- Mutexes
- Debouncers
- Technical helpers

// 🧲 FETCHERS ------------------------------------------------------------------------------ \\
// For data retrieval
- Getters
- Data fetching methods

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// For complex operations and business logic
- Business logic methods
- Complex calculations
- Data transformations
- Helper functions
- Formatters

// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
// For state mutations and updates
- Methods that change state
- Update operations
- API calls
```

## 📋 Examples

### Service Class Example
```dart
class ExampleService extends BaseService {
  // 📍 LOCATOR
  static ExampleService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(ExampleService.new);

  // 🧩 DEPENDENCIES
  final _otherService = OtherService.locate;

  // 🎩 STATE
  final _items = Informer<List<ItemDto>>([]);

  // 🧲 FETCHERS
  ValueListenable<List<ItemDto>> get items => _items;
  String get genId => _generateId();

  // 🪄 MUTATORS
  Future<Response> createItem({required ItemDto item}) =>
      createDoc(doc: item);
}
```

### ViewModel Example
```dart
class ExampleViewModel extends BaseViewModel {
  // 📍 LOCATOR
  static ExampleViewModel get locate => GetIt.I.get();

  // 🧩 DEPENDENCIES
  final _service = ExampleService.locate;
  final _dialogService = DialogService.locate;

  // 🎩 STATE
  late final _form = ExampleForm.locate;

  // 🧲 FETCHERS
  ValueListenable<List<ItemDto>> get items => _service.items;

  // 🪄 MUTATORS
  Future<void> onActionPressed() {
    _dialogService.showDialog(...);
  }
}
```

## ✨ Benefits

1. 🎯 **Quick Navigation**
   - Visual markers make it easy to find specific sections
   - Consistent structure across all files
   - Quick jumping using search (e.g., "MUTATORS")

2. 🧭 **Clear Organization**
   - Each piece of code has its designated place
   - Reduces decision fatigue about where to put new code
   - Makes code reviews easier

3. 📚 **Maintainability**
   - Clear separation of concerns
   - Easy to find related functionality
   - Consistent across the codebase

4. 🤝 **Team Collaboration**
   - Everyone knows where to find things
   - Consistent structure makes code more predictable
   - Easier onboarding for new team members

## 💡 Pro Tip

Save the following as a snippet named `allheaders` to quickly scaffold new classes with all sections:

```dart
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// 🎩 STATE --------------------------------------------------------------------------------- \\
// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// 🧲 FETCHERS ------------------------------------------------------------------------------ \\
// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
```

Type `allheaders` and use your IDE's snippet expansion to insert all section headers with proper formatting. 