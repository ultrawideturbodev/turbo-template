---
description: Planning Template - How we document and track project planning and execution
globs:
---

# 🎯 1. Goal(s)
*Clear specific outcome(s) we aim to achieve.*

- [x] 1.1. Integrate a responsive Settings icon in the navigation:
  - On desktop: The Settings icon should appear at the bottom of the navigation rail and navigate using the SettingsRouter via the navigation shell.
  - On mobile: The Settings icon should appear as a trailing element in the Home view app bar and navigate using HomeRouter.

# 📚 2. Context
> *Important information relevant to the plan.*

- [x] 2.1. The current navigation system uses a navigation rail for desktop layouts and an app bar for mobile layouts.
- [x] 2.2. Routing is managed by HomeRouter (for mobile) and SettingsRouter (for desktop) in conjunction with the navigation shell.
- [x] 2.3. Device type is determined via TDeviceType, ensuring the correct layout is presented.
- [x] 2.4. This change aims to enhance the accessibility and consistency of navigation to the Settings view across different device types.
- [x] 2.5. Project uses specific patterns for service and router implementation:
  - Services and routers use GetIt for dependency injection
  - Clear section structure with emoji headers (📍 LOCATOR, 🧩 DEPENDENCIES, etc.)
  - Proper locate and lazyLocate patterns
  - Routers extend BaseNavigation

# 🎓 3. Assumptions
> *List of critical assumptions that need validation before proceeding.*

- [x] 3.1. TDeviceType correctly differentiates between mobile and desktop (and tablet) devices.
- [x] 3.2. The existing HomeRouter, SettingsRouter, and navigation shell are correctly configured and can handle the new routing.
  - Confirmed: StatefulNavigationShell usage pattern is correct including web-specific handling
  - Confirmed: HomeRouter provides the correct implementation pattern to follow
- [x] 3.3. UI components like NavigationRail and TAppBar can be modified to accommodate an additional settings icon without major redesign.
- [x] 3.4. The chosen icon (default Icons.settings) aligns with the app's design standards.

# ❓ 4. Questions
> *Specific questions about implementation details that need answers.*

- [x] 4.1. Use the default Icons.settings.
- [x] 4.2. Adhere to the existing design standards for spacing, animations, and tooltips.
- [x] 4.3. The settings icon should appear at the bottom of the navigation rail.
- [x] 4.4. No additional routing transition considerations are required.

# 🪜 5. Plan
> *Detailed step-by-step actions required to achieve the goal.*

# 🎯 Main Objective: Integrate responsive Settings icon for seamless navigation

- [x] 1. Fix SettingsRouter Implementation:
  - [x] 1.1. Move locator methods to top section with 📍 LOCATOR header
  - [x] 1.2. Add lazyLocate getter following HomeRouter pattern
  - [x] 1.3. Add all missing section headers matching HomeRouter
  - [x] 1.4. Add SettingsRouter.registerFactory() to _registerRouters() in locator.dart

- [x] 2. Fix HomeViewModel Implementation:
  - [x] 2.1. Fix service usage to follow project patterns (remove incorrect () after lazyLocate)
  - [x] 2.2. Add proper section organization with emoji markers
  - [x] 2.3. Implement onSettingsPressed using correct router pattern
  - [x] 2.4. Fix onLogoutPressed to use correct service pattern

- [x] 3. Update Mobile Layout:
  - [x] 3.1. In the Home view, modify the app bar to add a trailing settings icon
  - [x] 3.2. Configure the onPressed event of the settings icon to navigate to the Settings view via SettingsRouter
  - [x] 3.3. Ensure the settings icon is visible only on mobile devices

- [x] 4. Update Desktop Layout:
  - [x] 4.1. In the navigation rail (shell_view.dart), add a settings icon at the bottom
  - [x] 4.2. Configure the onPressed event of the settings icon to navigate to the Settings view using SettingsRouter
  - [x] 4.3. Fix StatefulNavigationShell usage in navigation
  - [x] 4.4. Verify proper alignment and spacing with existing navigation items

- [x] 5. Testing and Validation:
  - [x] 5.1. Test the mobile layout to ensure the settings icon appears in the app bar and navigates correctly
  - [x] 5.2. Test on desktop to ensure the settings icon is placed appropriately in the navigation rail and functions as intended
  - [x] 5.3. Validate that these changes do not interfere with any existing navigation functionality 