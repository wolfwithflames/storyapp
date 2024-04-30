import 'package:storyapp/core/constants/api_routes.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/logger/app_logger.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/core/models/dated_stories/story.dart';
import 'package:storyapp/core/services/http/http_service.dart';
import 'package:storyapp/getIt.dart';

abstract class StoryRemoteDataSource {
  Future<ApiResponse<List<DatedStories>>> getPastWeek();
  Future<ApiResponse<Story>> addStory({
    required String title,
    required String description,
    required String imageUrl,
  });
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final httpService = getIt<HttpService>();

  @override
  Future<ApiResponse<List<DatedStories>>> getPastWeek() async {
    final postsMap =
        await httpService.getHttp(ApiRoutes.story) as Map<String, dynamic>;
    AppLog.prettyPrint(postsMap);

    return ApiResponse.fromJson(postsMap,
        (data) => (data as List).map((e) => DatedStories.fromJson(e)).toList());
  }

  @override
  Future<ApiResponse<Story>> addStory({
    required String title,
    required String description,
    required String imageUrl,
  }) async {
    final postsMap = await httpService.postHttp(ApiRoutes.story, {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    }) as Map<String, dynamic>;
    AppLog.prettyPrint(postsMap);
    return ApiResponse.fromJson(postsMap, (data) => Story.fromJson(data));
  }
}
