import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

import '../extensions/string_extension.dart';
import '../typedefs/lazy_locator.dart';

FormFieldValidator kValueValidatorsMultiple(List<FormFieldValidator> validators) =>
    (valueCandidate) {
      for (final validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };

FormFieldValidator<T> kValueValidatorsIsTrue<T>({required LazyLocator<String> errorText}) {
  return (T? valueCandidate) {
    if (valueCandidate is bool && valueCandidate) {
      return null;
    }
    return errorText();
  };
}

FormFieldValidator<T> kValueValidatorsIsValidNumber<T>({required LazyLocator<String> errorText}) {
  return (T? valueCandidate) {
    if (valueCandidate is String && num.tryParse(valueCandidate) != null) {
      return null;
    }
    return errorText();
  };
}

FormFieldValidator<T> kValueValidatorsRequired<T>({required LazyLocator<String> errorText}) {
  return (T? valueCandidate) {
    if (valueCandidate == null ||
        (valueCandidate is String && valueCandidate.trim().isEmpty) ||
        (valueCandidate is Iterable && valueCandidate.isEmpty) ||
        (valueCandidate is Map && valueCandidate.isEmpty)) {
      return errorText();
    }
    return null;
  };
}

FormFieldValidator<T> kValueValidatorsEmail<T>({required LazyLocator<String> errorText}) {
  return (T? valueCandidate) {
    String? errorMessage;
    errorMessage =
        valueCandidate is String && EmailValidator.validate(valueCandidate) ? null : errorText();
    return errorMessage;
  };
}

FormFieldValidator<T> kValueValidatorsMaxLength<T>({
  required int maxLength,
  required LazyLocator<String> errorText,
}) {
  assert(maxLength > 0);
  return (T? valueCandidate) {
    assert(valueCandidate is String || valueCandidate is Iterable || valueCandidate == null);
    var valueLength = 0;
    if (valueCandidate is String) valueLength = valueCandidate.length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    return null != valueCandidate && valueLength > maxLength ? errorText() : null;
  };
}

FormFieldValidator<T> kValueValidatorsNoProfanity<T>({
  required List<String> profanityWords,
  required LazyLocator<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate is String) {
      for (final word in profanityWords) {
        if (valueCandidate.toLowerCase().contains(word.toLowerCase())) {
          return errorText();
        }
      }
    }
    return null;
  };
}

FormFieldValidator<T> kValueValidatorsMinLength<T>({
  required int minLength,
  required LazyLocator<String> errorText,
}) {
  return (T? valueCandidate) {
    assert(valueCandidate is String || valueCandidate is Iterable || valueCandidate == null);
    var valueLength = 0;
    if (valueCandidate is String) valueLength = valueCandidate.trim().length;
    if (valueCandidate is Iterable) valueLength = valueCandidate.length;
    return null == valueCandidate || valueLength < minLength ? errorText() : null;
  };
}

FormFieldValidator<T> kValueValidatorsEquals<T>(
  T? Function() other, {
  required LazyLocator<String> errorText,
}) =>
    (T? valueCandidate) => valueCandidate != other() ? errorText() : null;

FormFieldValidator<T> kValueValidatorsIsValidUsernameNaked<T>({
  required LazyLocator<String> errorText,
}) {
  return (T? valueCandidate) {
    if (valueCandidate != null &&
        valueCandidate is String &&
        valueCandidate.naked.isValidUsername) {
      return null;
    }
    return errorText();
  };
}
