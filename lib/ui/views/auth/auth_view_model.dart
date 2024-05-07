import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/data/countries.dart';
import 'package:storyapp/core/data/enums.dart';
import 'package:storyapp/core/exceptions/repository_exception.dart';
import 'package:storyapp/core/models/user/user.dart' as user;
import 'package:storyapp/core/repositories/users_repository/users_repository.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/core/utils/pref_utils.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';
import 'package:storyapp/ui/widgets/toast.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/firebase_utils/firebase_utils.dart';

class AuthViewModel extends AppBaseViewModel {
  final _usersRepository = getIt<UsersRepository>();

  final pinController = TextEditingController();
  final phoneController = TextEditingController();
  final focusNode = FocusNode();
  Country? _selectedCountry;

  final formFieldKey = GlobalKey<FormState>();

  Country? get selectedCountry => _selectedCountry;

  Color focusedBorderColor = Colors.white;
  Color fillColor = Colors.white;
  Color borderColor = Colors.white;

  String verificationCode = "";
  int resendToken = -1;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(
        color: Colors.white,
      ),
    ),
    textStyle: const TextStyle(
      color: Colors.white,
    ),
  );
  bool isOtpSent = false;

  String get loginButtonText => isOtpSent ? "Verify" : "Send OTP";

  /// Executes the authentication button action.
  ///
  /// This method is called when the authentication button is pressed.
  /// It first validates the form field using the `validate` method of the `formFieldKey` global key.
  /// If the validation fails, the method returns without performing any further actions.
  /// If the OTP (One-Time Password) is already sent, the method calls the `onVerifyOtpPressed` method.
  /// Otherwise, it sets the view state to `ViewState.busy`, sends the OTP using the `sendOtp` method,
  /// sets the `isOtpSent` flag to `true`, sets the view state to `ViewState.ideal`,
  /// and notifies the listeners using the `notifyListeners` method.
  ///
  /// Example usage:
  /// ```dart
  /// onAuthButtonPressed();
  /// ```
  ///
  /// Note: The `formFieldKey`, `isOtpSent`, `setViewState`, `sendOtp`, and `notifyListeners` variables/methods should be properly initialized/implemented before calling this method.
  /// The `ViewState` enum should be implemented to represent the different view states.
  /// The `onVerifyOtpPressed` method should be implemented to handle the OTP verification process.
  /// The `validate` method should be implemented to validate the form field.
  /// The `sendOtp` method should be implemented to send the OTP.
  /// The `isOtpSent` flag should be properly updated based on the OTP sending status.
  /// The `setViewState` method should be implemented to set the view state.
  /// The `notifyListeners` method should be implemented to notify the listeners of any changes.
  /// ```
  ///
  onAuthButtonPressed() async {
    final isValidated = formFieldKey.currentState!.validate();
    if (!isValidated) {
      return;
    }
    if (isOtpSent) {
      onVerifyOtpPressed();
      return;
    }
    setViewState(ViewState.busy);
    await sendOtp();
    isOtpSent = true;
    setViewState(ViewState.ideal);
    notifyListeners();
  }

  /// Notifies the listeners that the selected country has changed.
  ///
  /// This method updates the `_selectedCountry` variable with the new selected country
  /// and notifies the listeners using the `notifyListeners` method.
  ///
  /// Example usage:
  /// ```dart
  /// onCountryChanged(country);
  /// ```
  ///
  /// Note: The `_selectedCountry` variable should be properly initialized before calling this method.
  /// The `notifyListeners` method should be implemented to notify the listeners of any changes.
  /// The `Country` class should be implemented to represent the country model.
  ///
  void onCountryChanged(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  /// Verifies the OTP (One-Time Password) entered by the user.
  ///
  /// This method sets the view state to [ViewState.busy] and calls the `verifyOtp` method from the `FirebaseUtils` class to verify the OTP.
  /// If the OTP is successfully verified, it calls the `loginUser` method to log in the user.
  /// If the OTP verification fails, it sets the view state to [ViewState.ideal].
  ///
  /// Throws an exception if an error occurs during the OTP verification process.
  /// Logs the error using the `AppLog` class.
  ///
  /// Example usage:
  /// ```dart
  /// onVerifyOtpPressed();
  /// ```
  ///
  /// Note: This method should be called after the user enters the OTP and presses the verify button.
  /// The `pinController` and `verificationCode` variables should be properly initialized before calling this method.
  /// The `loginUser` method should be implemented to handle the login process.
  /// The `setViewState` method should be implemented to set the view state.
  /// The `AppLog` class should be implemented to handle logging.
  /// The `FirebaseUtils` class should be implemented to handle OTP verification.
  /// The `ViewState` enum should be implemented to represent the different view states.
  /// The `UserCredential` class should be implemented to represent the user credentials.
  /// The `phoneController` variable should be properly initialized before calling the `loginUser` method.
  /// ```
  ///
  Future<void> onVerifyOtpPressed() async {
    try {
      setViewState(ViewState.busy);
      UserCredential? userCredentials = await FirebaseUtils.instance
          .verifyOtp(pinController.text.trim(), verificationCode);

      if (userCredentials != null) {
        await loginUser(phoneController.text);
        return;
      }
      setViewState(ViewState.ideal);
    } catch (e) {
      setViewState(ViewState.ideal);
      botToast("$e");
    }
  }

  /// Sends an OTP (One-Time Password) to a phone number using Firebase authentication.
  /// Shows a progress dialog while the OTP is being sent and handles different callbacks from the Firebase authentication process.
  ///
  /// @param phoneNo The phone number to which the OTP will be sent.
  /// @return A Future that completes when the OTP is sent.
  Future<void> sendOtp() async {
    pinController.clear();
    await FirebaseUtils.instance.signInWithPhone(
      phoneNumber: "${_selectedCountry!.code}${phoneController.text}",
      verificationCompleted: (authCred) async {},
      verificationFailed: (exception) {
        if (exception.code == "missing-client-identifier") {
          botToast(AppStrings.reCAPTCHACheckError);
        } else if (exception.code == "too-many-requests") {
          botToast(AppStrings.reCAPTCHACheckError);
        } else if (exception.code == 'invalid-phone-number') {
          botToast(AppStrings.invalidPhoneNumber);
        } else {
          botToast(exception.message ?? "");
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationCode = verificationId;
        resendToken = forceResendingToken ?? -1;
      },
    );
  }

  /// Logs in a user with the provided phone number.
  ///
  /// This method sends a login request to the `_usersRepository` to log in the user with the given phone number.
  /// If the login request is successful and the user's profile is completed, it navigates to the registration page.
  /// If the login request is successful and the user's profile is not completed, it navigates to the main navigation page.
  /// If the login request fails, it sets the view state to `ViewState.ideal` and shows a snackbar with the error message.
  ///
  /// Throws a `RepositoryException` if an error occurs during the login process.
  ///
  /// Example usage:
  /// ```dart
  /// loginUser("1234567890");
  /// ```
  ///
  /// Note: The `_usersRepository` should be properly initialized before calling this method.
  /// The `ApiResponse` class should be implemented to represent the API response.
  /// The `user.User` class should be implemented to represent the user model.
  /// The `getIt` function should be implemented to get the instance of the `AppRouter` and `SnackBarService`.
  /// The `Routes` class should be implemented to represent the different routes.
  /// The `ViewState` enum should be implemented to represent the different view states.
  /// The `ConfirmSnackBarRequest` class should be implemented to represent the snackbar request.
  /// The `setViewState` method should be implemented to set the view state.
  /// The `notifyListeners` method should be implemented to notify the listeners of any changes.
  /// The `RepositoryException` class should be implemented to represent the repository exception.
  /// The `message` property should be implemented in the `ConfirmSnackBarRequest` and `RepositoryException` classes.
  /// ```
  ///
  loginUser(String phone) async {
    try {
      final ApiResponse<user.User> loginResponse =
          await _usersRepository.loginUser(phone.trim().removeAllWhitespace);
      if (loginResponse.status) {
        PrefsUtils.setAuthToken(loginResponse.data.token!);
        PrefsUtils.setUserData(loginResponse.data);
        if (!(loginResponse.data.isProfileCompleted ?? true)) {
          getIt<AppRouter>().replaceNamed(Routes.register);
          return;
        }
        getIt<AppRouter>().replaceNamed(Routes.mainNav);
      } else {
        await FirebaseUtils.instance.firebaseAuth.signOut();
        setIdealState();
        botToast(loginResponse.message);
      }
    } on RepositoryException catch (e) {
      await FirebaseUtils.instance.firebaseAuth.signOut();
      botToast(e.message);
      setIdealState();
    }
  }

  @override
  init() {
    super.init();
    if (kDebugMode) {
      phoneController.text = "9033550092";

      final country = countries.firstWhere((element) => element.code == '+91');
      onCountryChanged(country);
    }
    return this;
  }
}
