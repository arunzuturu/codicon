import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  isFirstTimeUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('isFirstTimeUser') == null) {
      sharedPreferences.setBool('isFirstTimeUser', true);
      return sharedPreferences.getBool('isFirstTimeUser');
    } else {
      sharedPreferences.setBool('isFirstTimeUser', false);
      return sharedPreferences.getBool('isFirstTimeUser');
    }
  }
}