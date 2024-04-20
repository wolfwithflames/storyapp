/// List of api end points
class ApiRoutes {
  ApiRoutes._();

  static const baseUrl = 'http://localhost:3000/api/';
  static const posts = '$baseUrl/posts';
  static const comments = '$baseUrl/comments';
  static const albums = '$baseUrl/albums';
  static const photos = '$baseUrl/photos';
  static const todos = '$baseUrl/todos';
  static const users = '$baseUrl/users';
  static const login = '${baseUrl}auth/login';
  static const updateProfile = '${baseUrl}auth/update-profile';
}
