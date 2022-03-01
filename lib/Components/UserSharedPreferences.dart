import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  static SharedPreferences _preferences = SharedPreferences.getInstance() as SharedPreferences;

  static const _keyUsername = 'username';
  static const _keyPhoneNumber = 'PhoneNumber';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static Future setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(_keyPhoneNumber, phoneNumber);

  static String? getUsername() => _preferences.getString(_keyUsername);
  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

}