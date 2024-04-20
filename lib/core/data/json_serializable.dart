class JsonSerializable {
  static bool boolParse(dynamic value) {
    return value.toString() == "1";
  }
}
