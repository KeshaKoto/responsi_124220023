import 'package:shared_preferences/shared_preferences.dart';

class authServices {
  static void simpanAkun(String username, String password) async {
    //bikin dulu shared preferencesnya
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    //simpan datanya ke local
    sharedPref.setString('username', username);
    sharedPref.setString('password', password);

    //nyoba ngambill data yang disimpan
    print(sharedPref.getString('username'));
    print(sharedPref.getString('password'));
  }

  static Future<bool> login(String username, String password) async {
    //bikin dulu shared preferencesnya
    SharedPreferences sharePref = await SharedPreferences.getInstance();

    //validasi login
    if (username == sharePref.get('username') &&
        password == sharePref.getString('password')) {
      return true;
    }
    return false;
  }
}
