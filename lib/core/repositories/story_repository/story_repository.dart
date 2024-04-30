import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/core/models/dated_stories/story.dart';

abstract class StoryRepository {
  Future<ApiResponse<List<DatedStories>>> getPastWeek();
  Future<ApiResponse<Story>> addStory({
    required String title,
    required String description,
    required String imageUrl,
  });
}
