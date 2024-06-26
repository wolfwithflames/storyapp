import 'package:get_it/get_it.dart';
import 'package:storyapp/core/data_sources/story/story_remote_data_source.dart';
import 'package:storyapp/core/data_sources/users/users_remote_data_source.dart';
import 'package:storyapp/core/repositories/story_repository/story_repository.dart';
import 'package:storyapp/core/repositories/story_repository/story_repository_impl.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service_impl.dart';
import 'package:storyapp/core/services/hardware_info/hardware_info_service.dart';
import 'package:storyapp/core/services/hardware_info/hardware_info_service_impl.dart';
import 'package:storyapp/core/services/http/http_service_impl.dart';
import 'package:storyapp/core/utils/file_helper.dart';
import 'package:storyapp/core/utils/image_compress_utils.dart';
import 'package:storyapp/core/utils/sharing_intents.dart';

import 'core/repositories/users_repository/users_repository.dart';
import 'core/repositories/users_repository/users_repository_impl.dart';
import 'core/services/http/http_service.dart';

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
  getIt.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources
  getIt.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl());
  getIt.registerLazySingleton<StoryRemoteDataSource>(
      () => StoryRemoteDataSourceImpl());

  /// Repositories
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());
  getIt.registerLazySingleton<StoryRepository>(() => StoryRepositoryImpl());

  // Utils
  getIt.registerLazySingleton<FileHelper>(() => FileHelperImpl());
  getIt.registerLazySingleton<ImageCompressHelper>(
      () => ImageCompressHelperImpl());
  getIt.registerLazySingleton<SharingIntent>(() => SharingIntent());
}
