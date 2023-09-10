import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static const _keyklist = 'kinaraList[][]';
  static const _keyBirthday = 'birthday';

  static Future init() async =>
      _preferences = await SharedPreferences?.getInstance();

  static Future setUsername(String username) async =>
      await _preferences?.setString(_keyUsername, username);

  static String? getUsername() => _preferences?.getString(_keyUsername);

  static Future removeUsername() async =>
      await _preferences?.remove(_keyUsername);

  static Future setKlist(List<String> klist, listName) async =>
      await _preferences?.setStringList(_keyklist + listName, klist);

  static List<String>? getKlist(listName) =>
      _preferences?.getStringList(listName);

  static Set<String>? getallKeys() => _preferences?.getKeys();

  // static List<String>? getPets() => _preferences?.getStringList(_keyPets);

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    return await _preferences?.setString(_keyBirthday, birthday);
  }

  static DateTime? getBirthday() {
    final birthday = _preferences?.getString(_keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }
}
