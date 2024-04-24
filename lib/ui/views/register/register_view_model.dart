import 'package:flutter/material.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:storyapp/core/repositories/users_repository/users_repository.dart';
import 'package:storyapp/core/services/snackbar/snack_bar_service.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';

import '../../../core/data/enums.dart';
import '../../../core/exceptions/repository_exception.dart';
import '../../../core/models/user/user.dart';
import '../../../core/router/router.dart';

class RegisterViewModel extends AppBaseViewModel {
  final _usersRepository = getIt<UsersRepository>();
  final _snackBarService = getIt<SnackBarService>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  GlobalKey<FormState> registerForm = GlobalKey<FormState>();

  Future<void> onSubmitPressed() async {
    if (!registerForm.currentState!.validate()) {
      return;
    }
    try {
      final ApiResponse<User> loginResponse =
          await _usersRepository.updateProfile(
        firstName: firstName.text,
        lastName: lastName.text,
      );
      if (loginResponse.status) {
        getIt<AppRouter>().replaceNamed(Routes.mainNav);
      } else {
        if (viewState != ViewState.ideal) {
          setViewState(ViewState.ideal);
          notifyListeners();
        }
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
}
