import 'package:storyapp/core/data/json_serializable.dart';

class ApiResponse<T> {
  bool status;
  String message;
  T data;
  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    return ApiResponse<T>(
      status: JsonSerializable.boolParse(json["status"]),
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": this.status,
        "message": this.message,
        "data": this.data,
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
