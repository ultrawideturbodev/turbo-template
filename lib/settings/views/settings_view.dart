import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/widgets/t_checkbox_field.dart';
import 'package:turbo_template/forms/widgets/t_color_picker_field.dart';
import 'package:turbo_template/forms/widgets/t_date_picker_field.dart';
import 'package:turbo_template/forms/widgets/t_date_range_picker_field.dart';
import 'package:turbo_template/forms/widgets/t_dropdown_field.dart';
import 'package:turbo_template/forms/widgets/t_number_input_field.dart';
import 'package:turbo_template/forms/widgets/t_phone_input_field.dart';
import 'package:turbo_template/forms/widgets/t_search_field.dart';
import 'package:turbo_template/forms/widgets/t_text_area_field.dart';
import 'package:turbo_template/forms/widgets/t_text_input_field.dart';
import 'package:turbo_template/routing/models/origin_arguments.dart';
import 'package:turbo_template/settings/views/settings_view_arguments.dart';
import 'package:turbo_template/settings/views/settings_view_model.dart';
import 'package:turbo_template/settings/views/settings_view_origin.dart';
import 'package:turbo_template/ui/constants/k_widgets.dart';
import 'package:turbo_template/ui/widgets/t_app_bar.dart';
import 'package:turbo_template/ui/widgets/t_responsive_column.dart';
import 'package:veto/data/models/base_view_model.dart';
import 'package:veto/veto.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.arguments,
    required this.origin,
  });

  final SettingsViewArguments arguments;
  final SettingsViewOrigin origin;

  static const String path = 'settings-view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>(
      isReactive: false,
      argumentBuilder: () => OriginArguments(data: arguments, origin: origin),
      builder: (context, model, isInitialised, child) {
        if (!isInitialised) return kWidgetsNothing;
        return Scaffold(
          headers: const [
            TAppBar(
              title: 'Settings',
            ),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: TResponsiveColumn(
              children: [
                TTextInputField(
                  fieldConfig: model.form.textInput,
                  label: 'Text Input Example',
                  subLabel: 'Enter any text you want to store',
                  hintText: 'Enter some text...',
                ),
                TColorPickerField(
                  fieldConfig: model.form.colorPicker,
                  label: 'Color Picker Example',
                  subLabel: 'Choose your favorite color',
                  hintText: 'Pick a color...',
                  onChanged: (value) => model.form.updateColorPicker(value),
                ),
                TDatePickerField(
                  fieldConfig: model.form.datePicker,
                  label: 'Date Picker Example',
                  subLabel: 'Select a single date',
                  hintText: 'Pick a date...',
                  onChanged: (value) => model.form.updateDatePicker(value),
                ),
                TDateRangePickerField(
                  fieldConfig: model.form.dateRangePicker,
                  label: 'Date Range Picker Example',
                  subLabel: 'Select a date range',
                  hintText: 'Pick a date range...',
                  onChanged: (value) => model.form.updateDateRangePicker(value),
                ),
                TSearchField(
                  fieldConfig: model.searchForm.search,
                  label: 'Search Example',
                  subLabel: 'Search through your content',
                  hintText: 'Search...',
                  leadingIcon: Icons.search,
                ),
                TCheckboxField(
                  formFieldConfig: model.form.checkbox,
                  trailing: const Text('Checkbox Example'),
                ),
                TNumberInputField(
                  formFieldConfig: model.form.numberInput,
                  label: 'Number Input Example',
                  subLabel: 'Enter a numeric value',
                ),
                TDropdownField<String>(
                  fieldConfig: model.form.select,
                  label: 'Select Example',
                  subLabel: 'Choose from predefined options',
                  hintText: 'Choose an option...',
                ),
                TTextAreaField(
                  fieldConfig: model.form.textArea,
                  label: 'Text Area Example',
                  subLabel: 'Enter multiple lines of text',
                  hintText: 'Enter multiple lines of text...',
                ),
                TPhoneInputField(
                  fieldConfig: model.form.phoneInput,
                  label: 'Phone Input Example',
                  subLabel: 'Enter your phone number with country code',
                  hintText: 'Enter phone number...',
                  onChanged: (value) => model.form.updatePhoneInput(value),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SettingsViewModel.locate,
    );
  }
}

