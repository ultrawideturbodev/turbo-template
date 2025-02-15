import '../../state/typedefs/lazy_locator_def.dart';
import '../typedefs/values_validator_def.dart';

ValuesValidatorDef kValuesValidatorsMultiple(List<ValuesValidatorDef> validators) => (value) {
      for (final validator in validators) {
        final validatorResult = validator.call(value);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };

ValuesValidatorDef<T> kValuesValidatorsRequired<T>({required LazyLocatorDef<String> errorText}) {
  return (List<T>? values) {
    if (values?.isEmpty ?? true) {
      return errorText();
    }
    return null;
  };
}
