import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/models/user/user.dart';

abstract class UsersRepository {
  /// - throws `RepositoryException` if fetch fails
  Future<ApiResponse<User>> loginUser(String phone);
  Future<ApiResponse<User>> updateProfile(
      {required String firstName, required String lastName});
}
