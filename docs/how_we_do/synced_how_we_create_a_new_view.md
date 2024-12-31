# 📝 How We Create A New View

A view in Roomy is a complete screen that users can navigate to. Each view follows our MVVM pattern and includes a view file, view model, arguments, and origin enum. Views are created using our custom script and then customized to fit the specific needs.

# 🎯 Suggested Approach
- [ ] Run the create_view script to generate the base files
- [ ] Update the view's path and UI elements
- [ ] Add the view's arguments and make them type-safe
- [ ] Create a route in the base router with parameter handling
- [ ] Add navigation methods in the feature router
- [ ] Register the view model in app setup

# 👨‍🏫 Tutorial

### 1. 🚀 Generate Base Files
```bash
cd roomy_flutter
dart scripts/create_view.dart
```
When prompted:
- Enter the feature name (e.g., "shopping_list")
- Enter the snake_case file name without '_view' (e.g., "manage_shopping_list")

### 2. ⚙️ Configure View
Update the view file:
```dart
class ManageShoppingListView extends StatelessWidget {
  static const String path = 'manage-shopping-list/:$kKeysShoppingListId';
  
  // Add required arguments and origin
  final ManageShoppingListViewArguments arguments;
  final ManageShoppingListViewOrigin origin;
  
  // Update UI elements like emoji and title
  header: EmojiHeader.scaffoldTitle(
    emoji: Emoji.shoppingCart,
    title: 'Manage Shopping List',
  ),
}
```

### 3. 🎯 Set Up Arguments
Make arguments type-safe in the arguments file:
```dart
class ManageShoppingListViewArguments extends ViewArguments {
  ManageShoppingListViewArguments({required this.shoppingListId});

  final String? shoppingListId;

  @override
  Map<String, dynamic> toMap() => {
    if (shoppingListId != null) kKeysShoppingListId: shoppingListId,
  };
}
```

### 4. 🛣️ Add Base Router Route
Add parameter handling and route in base_router.dart:
```dart
// Add parameter getter to handle all possible sources
extension on GoRouterState {
  String? get shoppingListId =>
      pathParameters[kKeysShoppingListId] ?? 
      uri.queryParameters[kKeysShoppingListId] ?? 
      arguments()?.shoppingListId;
}

// Add the route
static GoRoute get manageShoppingListView => GoRoute(
  path: ManageShoppingListView.path,
  redirect: (context, state) {
    if (!AuthService.locate.hasAuth.value) {
      return AuthView.path.asRootPath;
    }
    return null;
  },
  pageBuilder: (context, state) => _buildPage(
    child: ManageShoppingListView(
      arguments: ManageShoppingListViewArguments(
        shoppingListId: state.shoppingListId!,
      ),
      origin: ManageShoppingListViewOrigin.core,
    ),
  ),
);

// Add to parent router's routes
routes: [
  manageShoppingListView,
],
```

### 5. 🚦 Add Navigation Method
Add navigation method in the feature router:
```dart
Future<void> pushManageShoppingListView({
  required String shoppingListId,
}) async =>
    push(
      location: '$root'
          '/${ManageShoppingListView.path}'.withShoppingListId(shoppingListId),
      extra: [
        ManageShoppingListViewArguments(shoppingListId: shoppingListId),
      ],
    );
```

### 6. 📝 Register View Model
Add registration in app_setup.dart:
```dart
void registerViewModels() {
  ManageShoppingListViewModel.registerFactory();
}
```

# ✅ Checklist
- [ ] View files are generated and properly named
- [ ] View path includes any required parameters
- [ ] Arguments extend ViewArguments and handle all required data
- [ ] Origin enum is created with appropriate values
- [ ] Base router includes the route with proper auth checks (if applicable)
- [ ] Parameters are handled from path, query, and arguments (if possible)
- [ ] Feature router has navigation methods for the view
- [ ] View model is registered in app setup
- [ ] UI elements use appropriate Roomy widgets (RmyScaffold, RmyAppBar, etc.)
- [ ] Navigation methods follow the established pattern for path and arguments 