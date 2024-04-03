import 'package:stacked/stacked.dart';
import 'package:storyapp/main.dart';

import '../router/router.dart';

class SplashViewModel extends BaseViewModel {
  init() async {
    await Future.delayed(const Duration(seconds: 2), () {
      getIt<AppRouter>().replaceNamed(Routes.auth);
    });
  }
}
