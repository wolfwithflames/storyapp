import 'dart:convert';

import 'package:get_storage/get_storage.dart';

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
      _box.write(StorageKeys.authToken, value);

  static String? getAuthToken() => _box.read(StorageKeys.authToken);

  static void clearAuthToken() => _box.remove(StorageKeys.authToken);
}

class StorageKeys {
  static const authToken = "authToken";
  static const seen = "seen";
}

String getPrettyJSONString(jsonObject) {
  var encoder = const JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}
