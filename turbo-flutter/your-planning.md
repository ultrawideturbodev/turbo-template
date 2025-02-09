---
description: Planning Template - How we document and track project planning and execution
globs:
---

# 🎯 1. Goal(s)
*Clear specific outcome(s) we aim to achieve.*

- [ ] 1.1. Implement a draggable debug widget that floats above the main UI.
- [ ] 1.2. Ensure the widget is only visible during kDebugMode.
- [ ] 1.3. Provide three actionable features within the widget:
  - [ ] 1.3.1. Push/go to a specific route based on user input.
  - [ ] 1.3.2. Restart the app using Phoenix rebirth.
  - [ ] 1.3.3. Change theme using ThemeService.
- [ ] 1.4. Integrate confirmation dialogs for each action.

# 📚 2. Context
> *Important information relevant to the plan.*

- [ ] 2.1. The widget is intended for debugging and testing in development mode only.
- [ ] 2.2. It should overlay on the main interface without interfering with production functionality.
- [ ] 2.3. Valid for Flutter apps where kDebugMode is used to indicate development mode.
- [ ] 2.4. The app is expected to have a routing system, a Phoenix package for restarting, and a ThemeService for theme toggling.

# 🎓 3. Assumptions
> *List of critical assumptions that need validation before proceeding.*

- [ ] 3.1. The app is built with Flutter, thereby using `kDebugMode` to check for debug mode.
- [ ] 3.2. The app uses Phoenix for app restarts.
- [ ] 3.3. ThemeService is available to handle theme changes.
- [ ] 3.4. Basic UI components for dialogs and draggable widgets are available (e.g., Flutter's Draggable or GestureDetector).
- [ ] 3.5. The design relies on a single horizontal bar containing multiple icon buttons.

# ❓ 4. Questions
> *Specific questions about implementation details that need answers.*

- [ ] 4.1. What icons or visual style should be used for each action?
- [ ] 4.2. How should the route input be handled? Is it via a text field, a prompt, or a predefined list of routes?
- [ ] 4.3. Should the widget be resizable or strictly a fixed bar?
- [ ] 4.4. Are there any accessibility requirements or constraints for the debug widget?

# 🪜 5. Plan
> *Detailed step-by-step actions required to achieve the goal.*

# 🎯 Main Objective: Implement Debug Draggable Widget with Actions

- [ ] 1. **Design UI Layout:**
  - [ ] 1.1. Create a new widget (e.g., `DebugDraggableWidget`) that will only be rendered if `kDebugMode` is true.
  - [ ] 1.2. Structure the widget as a draggable container (consider using Flutter's `Draggable` or `GestureDetector` for drag handling).
  - [ ] 1.3. Layout inside the container should be a horizontal bar with three icon buttons:
    - [ ] 1.3.1. Icon for route push.
    - [ ] 1.3.2. Icon for app restart (Phoenix rebirth).
    - [ ] 1.3.3. Icon for theme change.

- [ ] 2. **Implement Feature: Navigate to a Specific Route:**
  - [ ] 2.1. On icon press, display a confirmation dialog.
  - [ ] 2.2. If confirmed, prompt the user to input a route (or select from a predefined list).
  - [ ] 2.3. Use Flutter's Navigator to push the specified route upon confirmation.

- [ ] 3. **Implement Feature: Restart App with Phoenix Rebirth:**
  - [ ] 3.1. On icon press, display a confirmation dialog.
  - [ ] 3.2. If confirmed, call `Phoenix.rebirth(context)` to restart the app.

- [ ] 4. **Implement Feature: Change Theme with ThemeService:**
  - [ ] 4.1. On icon press, display a confirmation dialog.
  - [ ] 4.2. If confirmed, invoke ThemeService's method to change or toggle the current theme.
  
- [ ] 5. **Integration and Testing:**
  - [ ] 5.1. Integrate the `DebugDraggableWidget` as an overlay in the main application (only in debug mode).
  - [ ] 5.2. Test that:
    - The widget appears only in development mode.
    - The widget can be dragged around.
    - Each icon performs its intended function after confirmation.
  - [ ] 5.3. Ensure that in production mode (`!kDebugMode`), the widget does not render.

- [ ] 6. **Documentation and Code Review:**
  - [ ] 6.1. Document the new widget and its integration.
  - [ ] 6.2. Add inline comments and update any relevant project documentation.
  - [ ] 6.3. Perform a code review to confirm adherence to project coding standards. 