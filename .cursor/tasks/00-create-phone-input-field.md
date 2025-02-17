# Create Phone Input Field Widget

## Description
Create a new form field widget that integrates the shadcn_flutter phone input component with our form field system.

## Implementation Steps

- [x] 1. Create new file `lib/forms/widgets/t_phone_input_field.dart`
   ```dart
   import 'package:flutter/material.dart' hide Theme;
   import 'package:shadcn_flutter/shadcn_flutter.dart';
   import 'package:turbo_template/forms/config/t_field_config.dart';
   import 'package:turbo_template/forms/widgets/t_form_field.dart';
   import 'package:turbo_template/state/extensions/context_extension.dart';
   ```

- [x] 2. Create TPhoneInputField widget class
   ```dart
   class TPhoneInputField extends StatefulWidget {
     const TPhoneInputField({
       required this.fieldConfig,
       super.key,
       this.crossAxisAlignment = CrossAxisAlignment.start,
       this.hintText,
       this.label,
       this.onChanged,
       this.onFocusChanged,
       this.onTap,
       this.trailing,
       this.trailingLabel,
       this.subLabel,
       this.countries,
       this.searchPlaceholder,
     });

     final CrossAxisAlignment crossAxisAlignment;
     final String? hintText;
     final String? label;
     final String? subLabel;
     final TFieldConfig<PhoneNumber> fieldConfig;
     final ValueChanged<PhoneNumber>? onChanged;
     final ValueChanged<bool>? onFocusChanged;
     final VoidCallback? onTap;
     final Widget? trailing;
     final Widget? trailingLabel;
     final List<Country>? countries;
     final Widget? searchPlaceholder;

     @override
     State<TPhoneInputField> createState() => _TPhoneInputFieldState();
   }
   ```

- [x] 3. Implement state class with proper initialization
   ```dart
   class _TPhoneInputFieldState extends State<TPhoneInputField> {
     @override
     void initState() {
       assert(widget.fieldConfig.fieldType.isPhoneInput);
       widget.fieldConfig.addListener(_rebuild);
       if (widget.onFocusChanged != null) {
         widget.fieldConfig.focusNode.addListener(_onFocusChanged);
       }
       super.initState();
     }

     void _onFocusChanged() => widget.onFocusChanged?.call(widget.fieldConfig.focusNode.hasFocus);
     void _rebuild() => setState(() {});

     @override
     void dispose() {
       widget.fieldConfig.removeListener(_rebuild);
       if (widget.onFocusChanged != null) {
         widget.fieldConfig.focusNode.removeListener(_onFocusChanged);
       }
       super.dispose();
     }
   }
   ```

- [x] 4. Implement build method with TFormField wrapper
   ```dart
   @override
   Widget build(BuildContext context) {
     final formFieldConfig = widget.fieldConfig;
     final formFieldTextStyle = context.texts.formField;
     final hintText = widget.hintText;
     final isReadOnly = formFieldConfig.isReadOnly;

     return TFormField(
       formFieldConfig: formFieldConfig,
       label: widget.label,
       subLabel: widget.subLabel,
       trailingLabel: widget.trailingLabel,
       child: SizedBox(
         height: 48,
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             crossAxisAlignment: widget.crossAxisAlignment,
             children: [
               PhoneInput(
                 initialValue: formFieldConfig.value,
                 onChanged: isReadOnly ? null : (value) => _onChanged(formFieldConfig, value),
                 countries: widget.countries,
                 searchPlaceholder: widget.searchPlaceholder,
                 filterPlusCode: true,
                 filterZeroCode: true,
                 filterCountryCode: true,
                 onlyNumber: true,
               ),
               if (widget.trailing != null) widget.trailing!,
             ],
           ),
         ),
       ),
     );
   }
   ```

- [x] 5. Implement onChange handler with validation
   ```dart
   void _onChanged(TFieldConfig<PhoneNumber> formFieldConfig, PhoneNumber value) {
     formFieldConfig.silentUpdateValue(value);
     if (formFieldConfig.shouldValidate.value) {
       formFieldConfig.isValid;
     }
     widget.onChanged?.call(value);
   }
   ```

## Files Changed
- New: `lib/forms/widgets/t_phone_input_field.dart` 