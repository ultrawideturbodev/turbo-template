# Add Color Picker to Settings View

## Description
Add the newly created `TColorPickerField` to the settings view for testing purposes. This involves updating the form configuration to use `ColorDerivative` instead of `String` for the color picker field and adding the field to the settings view UI.

## Implementation Steps

1. [x] Update `TExampleForm` color picker configuration
   - Update `TExampleDto` color picker type from `String` to `ColorDerivative`
   - Update `TFieldConfig<String>` to `TFieldConfig<ColorDerivative>` for color picker field
   - Update color picker getter and mutator method signatures

2. [x] Add color picker field to settings view
   - Import `TColorPickerField` in settings view
   - Add `TColorPickerField` to the `TResponsiveColumn` children
   - Configure with proper label, sub-label, and hint text
   - Use the existing form's color picker field config
   - Add `onChanged` callback to properly update the color value

## Files Changed
- `lib/settings/forms/t_example_form.dart`
- `lib/settings/views/settings_view.dart`

## Code Snippets

### Updated Color Picker Configuration
```dart
TFieldConfig<ColorDerivative>(
  id: fieldType,
  fieldType: TFieldType.colorPicker,
  initialValue: _initialValue?.colorPicker,
),
```

### Settings View Color Picker
```dart
TColorPickerField(
  fieldConfig: model.form.colorPicker,
  label: 'Color Picker Example',
  subLabel: 'Choose your favorite color',
  hintText: 'Pick a color...',
  onChanged: (value) => model.form.updateColorPicker(value),
),
``` 