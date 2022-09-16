import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  isFirstTimeUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('isFirstTimeUser') == null) {
      print("here");
      sharedPreferences.setBool('isFirstTimeUser', true);
      return sharedPreferences.getBool('isFirstTimeUser');
    } else {
      sharedPreferences.setBool('isFirstTimeUser', false);
      return sharedPreferences.getBool('isFirstTimeUser');
    }
  }
  codechefSetUser(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('codechef', username);
      return sharedPreferences.getString('codechef');
  }
  codechefGetUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('codechef');
  }
  codeforcesSetUser(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codeforces', username);
    return sharedPreferences.getString('codeforces');
  }
  codeforcesGetUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('codeforces');
  }
  leetCodeSetUser(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('leetCode', username);
    return sharedPreferences.getString('leetCode');
  }
  leetCodeGetUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('leetCode');
  }
}