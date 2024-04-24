import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/core/constants/app_colors.dart';
import 'package:storyapp/core/utils/validator_utils.dart';
import 'package:storyapp/ui/views/register/register_view_model.dart';
import 'package:storyapp/ui/widgets/edit_text.dart';

import '../../widgets/raised_button.dart';
import '../../widgets/text_view.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Center(
                  child: TextView(
                    'Hey we don\'t know you,',
                    textAlign: TextAlign.center,
                    textColor: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: TextView(
                    'Please introduce yourself',
                    textAlign: TextAlign.center,
                    textColor: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: model.registerForm,
                  child: Column(
                    children: [
                      EditText(
                        hint: "First Name",
                        controller: model.firstName,
                        validator: FormValidator.emptyValidator,
                      ),
                      const SizedBox(height: 20),
                      EditText(
                        hint: "Last Name",
                        controller: model.lastName,
                        validator: FormValidator.emptyValidator,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppRaisedButton(
                  title: "That's me",
                  titleColor: AppColors.primaryColor,
                  color: Colors.white,
                  borderRadius: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  onPressed: model.onSubmitPressed,
                  viewState: model.viewState,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
