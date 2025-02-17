# Add Phone Input Example to Settings View

## Description
Add a phone input field example to the settings view to demonstrate its usage and test integration with the form system.

## Implementation Steps

- [x] 1. Update settings view to import phone input field
   ```dart
   import 'package:turbo_template/forms/widgets/t_phone_input_field.dart';
   ```

- [x] 2. Add phone input field to settings view
   ```dart
   TPhoneInputField(
     fieldConfig: model.form.phoneInput,
     label: 'Phone Input Example',
     subLabel: 'Enter your phone number with country code',
     hintText: 'Enter phone number...',
     onChanged: (value) => model.form.updatePhoneInput(value),
   ),
   ```

- [x] 3. Update example form configuration
   ```dart
   // In t_example_form.dart
   TFieldType.phoneInput => TFieldConfig<PhoneNumber>(
     id: TFieldType.phoneInput,
     fieldType: TFieldType.phoneInput,
     initialValue: _initialValue?.phoneInput,
     valueValidator: kValueValidatorsMultiple([
       kValueValidatorsRequired(
         errorText: () => gStrings.thisFieldIsRequired,
       ),
       (dynamic value) {
         if (value == null) return null;
         if (value is! PhoneNumber) return 'Invalid phone number format';
         if (value.number.length < 6) {
           return 'Phone number must be at least 6 digits';
         }
         return null;
       },
     ]),
   ),
   ```

- [x] 4. Update example form getters and setters
   ```dart
   // In t_example_form.dart
   TFieldConfig<PhoneNumber> get phoneInput => formFieldConfig(TFieldType.phoneInput);
   void updatePhoneInput(PhoneNumber? value) => phoneInput.value = value;
   ```

## Files Changed
- Modified: `lib/settings/views/settings_view.dart`
- Modified: `lib/settings/forms/t_example_form.dart` 