import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/core/constants/app_colors.dart';
import 'package:storyapp/core/constants/constants.dart';
import 'package:storyapp/ui/views/auth/auth_view_model.dart';
import 'package:storyapp/ui/widgets/edit_text.dart';
import 'package:storyapp/ui/widgets/raised_button.dart';
import 'package:storyapp/ui/widgets/text_view.dart';

import '../../widgets/country_picker.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          key: model.scaffoldKey,
          body: SafeArea(
            child: Form(
              key: model.formFieldKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Center(
                      child: TextView(
                        'Welcome to the Storyboard',
                        textAlign: TextAlign.center,
                        textColor: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: TextView(
                        'You can add your own daily story here',
                        textAlign: TextAlign.center,
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CountryPicker(
                      onChanged: model.onCountryChanged,
                      value: model.selectedCountry,
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      duration: Constants.defaultAnimationDuration,
                      opacity: model.selectedCountry == null ? 0 : 1,
                      child: EditText(
                        outlineRadius: 40,
                        hint: "Phone",
                        controller: model.phoneController,
                        enable: !model.isOtpSent,
                        inputType: TextInputType.phone,
                        // maxLength: model.selectedCountry?.maxLength,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofillHints: const [
                          AutofillHints.telephoneNumberNational
                        ],
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                          AsYouTypeFormatter(
                            isoCode: model.selectedCountry?.alpha2Code ?? "",
                            dialCode: model.selectedCountry?.code ?? '',
                            onInputFormatted: (TextEditingValue value) {
                              model.phoneController.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      duration: Constants.defaultAnimationDuration,
                      opacity: model.isOtpSent ? 1 : 0,
                      child: Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: model.pinController,
                          focusNode: model.focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: model.defaultPinTheme,
                          // validator: (value) {
                          //   return value == '2222' ? null : 'Pin is incorrect';
                          // },
                          length: 6,
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            model.onAuthButtonPressed();
                          },

                          focusedPinTheme: model.defaultPinTheme.copyWith(
                            decoration:
                                model.defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: model.focusedBorderColor),
                              color: model.fillColor,
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          followingPinTheme: model.defaultPinTheme.copyWith(
                            decoration:
                                model.defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: model.focusedBorderColor),
                              color: model.fillColor,
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),

                          submittedPinTheme: model.defaultPinTheme.copyWith(
                            decoration:
                                model.defaultPinTheme.decoration!.copyWith(
                              color: model.fillColor,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: model.focusedBorderColor),
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          errorPinTheme: model.defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      duration: Constants.defaultAnimationDuration,
                      opacity: model.selectedCountry == null ? 0 : 1,
                      child: AppRaisedButton(
                        title: model.loginButtonText,
                        titleColor: AppColors.primaryColor,
                        color: Colors.white,
                        borderRadius: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        onPressed: model.onAuthButtonPressed,
                        viewState: model.viewState,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
