import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/data/countries.dart';
import 'package:storyapp/core/data/enums.dart';
import 'package:storyapp/core/exceptions/repository_exception.dart';
import 'package:storyapp/core/logger/app_logger.dart';
import 'package:storyapp/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:storyapp/core/models/user/user.dart' as user;
import 'package:storyapp/core/repositories/users_repository/users_repository.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/core/services/snackbar/snack_bar_service.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/utils/snackbar_utils.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';

import '../../../core/constants/app_strings.dart';
import '../../utils/firebase_utils/firebase_utils.dart';

class AuthViewModel extends AppBaseModel {
  final _usersRepository = getIt<UsersRepository>();
  final _snackBarService = getIt<SnackBarService>();

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

  void onCountryChanged(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  Future<void> onVerifyOtpPressed() async {
    try {
      setViewState(ViewState.busy);
      UserCredential? userCredentials = await FirebaseUtils.instance
          .verifyOtp(pinController.text.trim(), verificationCode);

      if (userCredentials != null) {
        await loginUser(phoneController.text);
      }
    } catch (e) {
      AppLog.e(e);
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
          SnackbarUtility.showSnackBar(
            scaffoldKey.currentState!,
            AppStrings.reCAPTCHACheckError,
          );
        } else if (exception.code == "too-many-requests") {
          SnackbarUtility.showSnackBar(
            scaffoldKey.currentState!,
            AppStrings.reCAPTCHACheckError,
          );
        } else if (exception.code == 'invalid-phone-number') {
          SnackbarUtility.showSnackBar(
            scaffoldKey.currentState!,
            AppStrings.invalidPhoneNumber,
          );
        } else {
          SnackbarUtility.showSnackBar(
            scaffoldKey.currentState!,
            exception.message ?? "",
          );
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationCode = verificationId;
        resendToken = forceResendingToken ?? -1;
      },
    );
  }

  loginUser(String phone) async {
    try {
      final ApiResponse<user.User> loginResponse =
          await _usersRepository.loginUser(phone);
      if (loginResponse.status) {
        if (loginResponse.data.isProfileCompleted ?? false) {
          getIt<AppRouter>().replaceNamed(Routes.register);
          return;
        }
        getIt<AppRouter>().replaceNamed(Routes.mainNav);
      } else {
        final request = ConfirmSnackBarRequest(
          (r) => r..message = loginResponse.message,
        );
        _snackBarService.showSnackBar(request);
      }
    } on RepositoryException catch (e) {
      final request = ConfirmSnackBarRequest(
        (r) => r..message = e.message,
      );
      _snackBarService.showSnackBar(request);
    }
  }

  @override
  init() {
    super.init();
    if (kDebugMode) {
      phoneController.text = "9033550092";
    }
    return this;
  }
}
