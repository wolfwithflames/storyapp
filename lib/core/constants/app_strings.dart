class AppStrings {
  static const String reCAPTCHACheckError =
      "The reCAPTCHA checks were unsuccessful, Please try again.";
  static const String tooManyRequestsError =
      "You reach the otp request limit. Please try again after some time";
  static const String invalidPhoneNumber =
      "The provided phone number is not valid.";
  static const String canNotLoginNow = "Can Not Login Now. Please try again.";

  static const String enterNo = "Please enter phone number";
  static const String enterValidNo = "Please enter valid phone number";
  static const String pleaseEnterOtp = "Please enter otp";

  ///Regex
  static RegExp phoneRegex = RegExp(r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$');
  static RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
