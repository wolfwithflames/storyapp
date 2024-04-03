import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/data/countries.dart';
import 'package:storyapp/data/enums.dart';
import 'package:storyapp/main.dart';
import 'package:storyapp/router/router.dart';

class AuthViewModel extends BaseViewModel {
  final pinController = TextEditingController();
  final phoneController = TextEditingController();
  final focusNode = FocusNode();
  Country? _selectedCountry;

  final formFieldKey = GlobalKey<FormState>();

  Country? get selectedCountry => _selectedCountry;

  ViewState _viewState = ViewState.ideal;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  Color focusedBorderColor = Colors.white;
  Color fillColor = const Color.fromRGBO(243, 246, 249, 0);
  Color borderColor = Colors.white;

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
      getIt<AppRouter>().pushNamed(Routes.mainNav);
      return;
    }
    setViewState(ViewState.busy);
    await Future.delayed(const Duration(seconds: 3));
    isOtpSent = !isOtpSent;
    setViewState(ViewState.ideal);
    notifyListeners();
  }

  void onCountryChanged(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
