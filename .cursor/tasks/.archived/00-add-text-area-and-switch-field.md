# Add Text Area and Switch Field to Settings View

## Description
Add text area and switch field components to the settings view to demonstrate their functionality.

## Implementation Steps

- [x] 1. Add imports to settings_view.dart
  ```dart
  import 'package:turbo_template/forms/widgets/t_text_area_field.dart';
  import 'package:turbo_template/forms/widgets/t_switch_field.dart';
  ```

- [x] 2. Add TTextAreaField to settings_view.dart's TResponsiveColumn children
  ```dart
  TTextAreaField(
    fieldConfig: model.form.textArea,
    label: 'Text Area Example',
    hintText: 'Enter multiple lines of text...',
  ),
  ```

- [x] 3. Add TSwitchField to settings_view.dart's TResponsiveColumn children
  ```dart
  TSwitchField(
    fieldConfig: model.form.toggleSwitch,
    label: 'Switch Example',
  ),
  ```

## Files Changed
- lib/settings/views/settings_view.dart

## Expected Result
- Text area field added to settings view with multiline input capability
- Switch field added to settings view with toggle functionality
- Both fields properly connected to form state management 