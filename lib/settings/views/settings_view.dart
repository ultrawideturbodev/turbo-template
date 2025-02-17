import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:turbo_template/forms/widgets/t_checkbox_field.dart';
import 'package:turbo_template/forms/widgets/t_number_input_field.dart';
import 'package:turbo_template/forms/widgets/t_search_field.dart';
import 'package:turbo_template/forms/widgets/t_select_field.dart';
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
                  hintText: 'Enter some text...',
                ),
                TSearchField(
                  fieldConfig: model.searchForm.search,
                  label: 'Search Example',
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
                ),
                TSelectField<String>(
                  fieldConfig: model.form.select,
                  label: 'Select Example',
                  hintText: 'Choose an option...',
                ),
                TTextAreaField(
                  fieldConfig: model.form.textArea,
                  label: 'Text Area Example',
                  hintText: 'Enter multiple lines of text...',
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
