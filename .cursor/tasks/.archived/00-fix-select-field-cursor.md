# Fix Select Field Cursor Style

## Description
The select field dropdown items currently show a basic cursor instead of a hand cursor when hovering. This needs to be fixed to improve user experience and maintain consistency with standard UI patterns.

## Steps
1. ✅ Locate the cursor style implementation in the select field component
   - Found in `SelectItemButton` class within `select.dart`
2. ✅ Update the cursor style to use `SystemMouseCursors.click` for interactive elements
   - Changed from `SystemMouseCursors.basic` to `SystemMouseCursors.click`
3. ✅ Test the changes to ensure proper cursor behavior
   - Confirmed hand cursor appears when hovering over dropdown items
4. ✅ Review and document the changes
   - Updated task file with implementation details
   - Change improves UX by providing proper visual feedback for interactive elements

## Status
- Started: [Current Date]
- Status: Completed
- Priority: Medium 