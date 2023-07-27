import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static String? token;

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (token == null) {
      token = prefs.getString('token');

      return token ??= '';
    }

    return token;
  }
}
