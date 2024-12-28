import '../typedefs/lazy_locator.dart';
import '../typedefs/values_validator.dart';

ValuesValidator kValuesValidatorsMultiple(List<ValuesValidator> validators) => (value) {
      for (final validator in validators) {
        final validatorResult = validator.call(value);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };

ValuesValidator<T> kValuesValidatorsRequired<T>({required LazyLocator<String> errorText}) {
  return (List<T>? values) {
    if (values?.isEmpty ?? true) {
      return errorText();
    }
    return null;
  };
}
