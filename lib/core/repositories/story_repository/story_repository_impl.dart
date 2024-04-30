import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/data_sources/story/story_remote_data_source.dart';
import 'package:storyapp/core/exceptions/cache_exception.dart';
import 'package:storyapp/core/exceptions/network_exception.dart';
import 'package:storyapp/core/exceptions/repository_exception.dart';
import 'package:storyapp/core/logger/app_logger.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/core/models/dated_stories/story.dart';
import 'package:storyapp/core/repositories/story_repository/story_repository.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service.dart';
import 'package:storyapp/getIt.dart';

class StoryRepositoryImpl implements StoryRepository {
  final remoteDataSource = getIt<StoryRemoteDataSource>();
  final connectivityService = getIt<ConnectivityService>();

  final _log = Logger('StoryRepositoryImpl');

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
      AppLog.e(e.message);
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }

  @override
  Future<ApiResponse<Story>> addStory({
    required String title,
    required String description,
    required String imageUrl,
  }) async {
    try {
      if (await connectivityService.isConnected) {
        final stories = await remoteDataSource.addStory(
          title: title,
          description: description,
          imageUrl: imageUrl,
        );
        return stories;
      }
      throw const SocketException("Not internet connected");
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely');
      AppLog.e(e.message);
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally');
      throw RepositoryException(e.message);
    }
  }
}
