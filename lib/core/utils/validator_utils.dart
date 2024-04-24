import 'package:get/get.dart';
import 'package:storyapp/core/constants/app_strings.dart';

/// This class contains static methods for validating form input values.
class FormValidator {
  /// Validates if the [value] is empty.
  ///
  /// If the [value] is empty, it returns the [message] parameter value,
  /// which is "Please enter value" by default. Otherwise, it returns `null`.
  ///
  /// Example usage:
  /// ```dart
  /// String? result = FormValidator.emptyValidator(value);
  /// ```
  static String? emptyValidator(String? value,
      {String message = "Please enter value"}) {
    if (value != null) {
      if (value.isEmpty) {
        return message;
      }
    }
    return null;
  }

  /// Validates if the [value] is a valid phone number.
  ///
  /// If the [value] is empty, it returns the "Please enter phone number" value.
  /// Then it checks if the trimmed length of the [value] is less than 10.
  /// If it is, it returns the "Please enter a valid phone number" value.
  /// Finally, it checks if the [value] matches the phone number regex defined in `AppStrings`.
  /// If it doesn't match, it returns the "Please enter a valid phone number" value.
  /// Otherwise, it returns `null`.
  ///
  /// Example usage:
  /// ```dart
  /// String? result = FormValidator.phoneValidator(value);
  /// ```
  static String? phoneValidator(value) {
    if (value!.isEmpty) {
      return AppStrings.enterNo;
    }
    if (value.trim().length < 10) {
      return AppStrings.enterValidNo;
    }
    if (!AppStrings.phoneRegex.hasMatch(value.trim())) {
      return AppStrings.enterValidNo;
    }
    return null;
  }

  /// Validates if the [value] is a valid email address.
  ///
  /// If the [value] is empty, it returns the "Please enter email" value.
  /// Then it checks if the [value] is a valid email using the `isEmail` property.
  /// If it is not a valid email, it returns the "Please enter a valid email" value.
  /// Otherwise, it returns `null`.
  ///
  /// Example usage:
  /// ```dart
  /// String? result = FormValidator.emailValidator(value);
  /// ```
  static String? emailValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "Please enter email";
      }
      if (!value.isEmail) {
        return "Please enter valid email";
      }
    }
    return null;
  }

  static String? urlValidator(value) {
    if (value!.isEmpty) {
      return "Please Enter URL";
    }

    if (value!.isNotEmpty && !(Uri.tryParse(value)?.hasAbsolutePath ?? false)) {
      return "Enter a valid URL";
    }
    return null;
  }
}
