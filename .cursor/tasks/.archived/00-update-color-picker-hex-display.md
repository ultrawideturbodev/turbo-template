# Update Color Picker Hex Display

## Description
Hide the alpha prefix ("FF") in the color picker's hex code display by setting `showAlpha` to false.

## Implementation Steps

1. [x] Update color picker field to hide alpha in hex display
   - Set `showAlpha: false` in `ColorInput` widget

## Files Changed
- `lib/forms/widgets/t_color_picker_field.dart`

## Code Snippets

### Updated ColorInput
```dart
ColorInput(
  color: formFieldConfig.value ?? ColorDerivative.fromColor(Colors.black),
  onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
  showAlpha: false,
  pickerMode: widget.mode,
  allowPickFromScreen: widget.allowPickFromScreen,
  showLabel: true,
  placeholder: hintText != null ? Text(hintText, style: formFieldTextStyle) : null,
),
``` 