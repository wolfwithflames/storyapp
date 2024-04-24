import 'dart:io';

import 'package:logging/logging.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/exceptions/cache_exception.dart';
import 'package:storyapp/core/exceptions/network_exception.dart';
import 'package:storyapp/core/exceptions/repository_exception.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/core/models/user/user.dart';
import 'package:storyapp/core/repositories/users_repository/users_repository.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service.dart';
import 'package:storyapp/core/users/users_remote_data_source.dart';
import 'package:storyapp/getIt.dart';

class UsersRepositoryImpl implements UsersRepository {
  final remoteDataSource = getIt<UsersRemoteDataSource>();

  final connectivityService = getIt<ConnectivityService>();

  final _log = Logger('UsersRepositoryImpl');

  @override
  Future<ApiResponse<User>> loginUser(String phone) async {
    try {
      if (await connectivityService.isConnected) {
        final user = await remoteDataSource.loginUser(phone);
        return user;
      }
      throw const SocketException("Not internet connected");
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<ApiResponse<User>> updateProfile(
      {required String firstName, required String lastName}) async {
    try {
      if (await connectivityService.isConnected) {
        final user = await remoteDataSource.updateProfile(
            firstName: firstName, lastName: lastName);
        return user;
      }
      throw const SocketException("Not internet connected");
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<ApiResponse<List<DatedStories>>> getPastWeek() async {
    try {
      if (await connectivityService.isConnected) {
        final stories = await remoteDataSource.getPastWeek();
        return stories;
      }
      throw const SocketException("Not internet connected");
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
