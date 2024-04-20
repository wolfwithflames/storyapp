import 'package:storyapp/core/constants/api_routes.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/models/user/user.dart';
import 'package:storyapp/core/services/http/http_service.dart';
import 'package:storyapp/getIt.dart';

abstract class UsersRemoteDataSource {
  Future<ApiResponse<User>> loginUser(String phone);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final httpService = getIt<HttpService>();

  @override
  Future<ApiResponse<User>> loginUser(String phone) async {
    final postsMap = await httpService.postHttp(ApiRoutes.login, {
      "phone": phone,
    }) as Map<String, dynamic>;
    return ApiResponse<User>.fromJson(postsMap, (data) => User.fromJson(data));
  }
}
