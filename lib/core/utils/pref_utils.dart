import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:storyapp/core/models/user/user.dart';

class PrefsUtils {
  static final _box = GetStorage();

  PrefsUtils._();

  static void set(String key, dynamic value) => _box.write(key, value);

  static dynamic get<T>(String key) => _box.read<T>(key);

  /// Intro seen prefrences
  // static void setIntroSeen(dynamic value) =>
  //     _box.write(StorageKeys.seen, value);

  // static dynamic getIntroSeen<T>() => _box.read(StorageKeys.seen);

  // static dynamic clearIntroSeen<T>() => _box.remove(StorageKeys.seen);

  /// Auth token prefrences
  static void setAuthToken(String value) =>
      _box.write(PrefKeys.authToken, value);

  static String? getAuthToken() => _box.read(PrefKeys.authToken);

  static void clearAuthToken() => _box.remove(PrefKeys.authToken);

  /// User data prefrences
  static void setUserData(User value) =>
      _box.write(PrefKeys.userData, value.toJson());

  static User? getUserData<T>() {
    var data = _box.read(PrefKeys.userData);
    if (data != null) {
      return User.fromJson(data);
    }
    return null;
  }

  static void clearUserData() => _box.remove(PrefKeys.userData);
}

class PrefKeys {
  static const authToken = "authToken";
  static const seen = "seen";
  static const userData = "userData";
}

String getPrettyJSONString(jsonObject) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}
