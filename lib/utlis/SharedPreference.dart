
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreference {
  static late SharedPreferences preferences;

  static const String firstLogin = 'is_first_time';
  static const String userId = 'osrID';
  static const String fullName = 'fullName';
  static const String position = 'position';


  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static bool get isFirstTime =>
      preferences.getBool(firstLogin) ?? false;

  static set isFirstTime(bool value) =>
      preferences.setBool(firstLogin, value);

  static String get osrId => preferences.getString(userId) ?? "";
  static String get osrFullName => preferences.getString(fullName) ?? "";
  static String get osrPosition => preferences.getString(position) ?? "";

  static set osrID(String? value) => preferences.setString(userId, value ?? "");
  static set fullName(String? value) => preferences.setString(fullName, value ?? "");
  static set position(String? value) => preferences.setString(position, value ?? "");

  static void clear() {
    preferences.clear();
  }
}