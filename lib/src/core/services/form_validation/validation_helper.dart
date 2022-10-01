import 'package:bookingapp/src/core/utils/app_constants.dart';
import 'package:bookingapp/src/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';

part 'validation_item.dart';

class ValidationHelper with ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _pass = ValidationItem(null, null);
  ValidationItem _passConfirm = ValidationItem(null, null);

  ValidationItem get name => _name;
  ValidationItem get email => _email;
  ValidationItem get pass => _pass;
  ValidationItem get passConfirm => _passConfirm;

  bool get nameValid => _name.value != null;
  bool get emailValid => _email.value != null;
  bool get passValid => _pass.value != null;
  bool get passConfirmValid => _passConfirm.value != null;

  bool get enableRegisterButton => nameValid && emailValid && passValid && passConfirmValid;

  bool get enableLoginButton => emailValid && passValid;

  // TODO: in names, check if all characters are of the same language
  // validate name form (register only)
  void validateNameForm(String? value) {
    if (value!.isEmpty) {
      _name = ValidationItem(null, AppStrings.requiredFieldMsg);
    } else if (AppConstants.nameContainsSpaces(value)) {
      _name = ValidationItem(null, AppStrings.noSpacesMsg);
    } else if (AppConstants.nameContainsNums(value)) {
      _name = ValidationItem(null, AppStrings.noNumbersMsg);
    } else if (AppConstants.nameContainsSpChar(value)) {
      _name = ValidationItem(null, AppStrings.noSpCharMsg);
    } else if (!AppConstants.nameMatchesLength(value)) {
      _name = ValidationItem(null, AppStrings.nameMatchesLengthMsg);
    } else {
      _name = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // validate email form (login and register)
  void validateEmailForm(String? value) {
    if (value!.isEmpty) {
      _email = ValidationItem(null, AppStrings.requiredFieldMsg);
    } else if (AppConstants.emailContainsSpaces(value)) {
      _email = ValidationItem(null, AppStrings.noSpacesMsg);
    } else if (!AppConstants.emailFormValid(value)) {
      _email = ValidationItem(null, AppStrings.emailFormErrorMsg);
    } else {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // validate password form (register only)
  void validateRegisterPassForm(String? value) {
    if (value!.isEmpty) {
      _pass = ValidationItem(null, AppStrings.requiredFieldMsg);
    } else if (!AppConstants.passContainsOneUppercase(value)) {
      _pass = ValidationItem(null, AppStrings.twoUppercaseMsg);
    } else if (!AppConstants.passContainsOneLowercase(value)) {
      _pass = ValidationItem(null, AppStrings.twoLowercaseMsg);
    } else if (!AppConstants.passContainsOneNum(value)) {
      _pass = ValidationItem(null, AppStrings.twoNumMsg);
    } else if (!AppConstants.passContainsOneSpChar(value)) {
      _pass = ValidationItem(null, AppStrings.twoSpCharMsg);
    } else if (!AppConstants.passMatchesLength(value)) {
      _pass = ValidationItem(null, AppStrings.passwordMatchesLengthMsg);
    } else {
      _pass = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // validate password form (login only)
  void validateLoginPassForm(String? value) {
    if (value!.isEmpty) {
      _pass = ValidationItem(null, AppStrings.requiredFieldMsg);
    } else if (!AppConstants.passMatchesLength(value)) {
      _pass = ValidationItem(null, AppStrings.passwordMatchesLengthMsg);
    } else {
      _pass = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // validate password confirmation form (register only)
  void validatePassConfirmForm(String? value) {
    if (value!.isEmpty) {
      _passConfirm = ValidationItem(null, AppStrings.requiredFieldMsg);
    } else if (!AppConstants.passesAreIdentical(value, _pass.value)) {
      _passConfirm = ValidationItem(null, AppStrings.passwordsNotIdenticalMsg);
    } else {
      _passConfirm = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // submit data after validation
  void submitLoginData() {
    debugPrint("email: ${_email.value}"
        "\n"
        "password: ${_pass.value}");
  }

  void submitRegisterData() {
    debugPrint(
      "name: ${_name.value}"
      "\n"
      "email: ${_email.value}"
      "\n"
      "password: ${_pass.value}"
      "\n"
      "passwordConfirmation: ${_passConfirm.value}",
    );
  }
}
