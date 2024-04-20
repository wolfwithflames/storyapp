import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/getIt.dart';

import '../../../core/router/router.dart';

class SplashViewModel extends BaseViewModel {
  init() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser == null) {
        getIt<AppRouter>().replaceNamed(Routes.auth);
      } else {
        getIt<AppRouter>().replaceNamed(Routes.mainNav);
      }
    });
  }
}
