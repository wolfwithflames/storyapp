import 'package:get_it/get_it.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service_impl.dart';
import 'package:storyapp/core/services/hardware_info/hardware_info_service.dart';
import 'package:storyapp/core/services/hardware_info/hardware_info_service_impl.dart';
import 'package:storyapp/core/services/http/http_service_impl.dart';
import 'package:storyapp/core/services/snackbar/snack_bar_service_impl.dart';
import 'package:storyapp/core/users/users_remote_data_source.dart';
import 'package:storyapp/ui/utils/file_helper.dart';

import 'core/repositories/users_repository/users_repository.dart';
import 'core/repositories/users_repository/users_repository_impl.dart';
import 'core/services/http/http_service.dart';
import 'core/services/snackbar/snack_bar_service.dart';

GetIt getIt = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> initGetit() async {
  // App Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Services
  getIt.registerLazySingleton<HardwareInfoService>(
    () => HardwareInfoServiceImpl(),
  );
  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  getIt.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  getIt.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  getIt.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(),
  );

  /// Repositories
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());

  // Utils
  getIt.registerLazySingleton<FileHelper>(() => FileHelperImpl());
}
