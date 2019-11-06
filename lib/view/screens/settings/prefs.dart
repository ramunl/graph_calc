import 'package:shared_preferences/shared_preferences.dart';

const KEY_USE_WOLFRAM_API = "to_use_wolfram_API";

SharedPreferences prefs;

Future<SharedPreferences> getPrefs() async {
  if (prefs == null) {
    prefs = await SharedPreferences.getInstance();
  }
  return prefs;
}

setBool(String key, bool val) async {
  prefs = await getPrefs();
  prefs.setBool(key, val);
}

Future<bool> getBool(String key) async {
  prefs = await getPrefs();
  return prefs.getBool(key) ?? false;
}
