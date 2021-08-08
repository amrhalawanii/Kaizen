import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Helpers/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMethods {
  static String userName = "USERNAME";
  static String userID = "USERID";
  static String userEmail = "EMAIL";

  static saveUserSharedPreferences(KaizenUser user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      await preferences.setString(userName, user.username);
      await preferences.setString(userID, userName);
      await preferences.setString(userEmail, user.email);
    } catch (e) {
      print("Error + " + e.toString());
    }
  }

  static getUserSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    KaizenUser user;
    try {
      user = KaizenUser(preferences.getString(userID)!,
          preferences.getString(userName)!, preferences.getString(userEmail)!);
      activeUser = user;
    } catch (e) {
      print("ERROR2 " + e.toString());
    }
  }

  static clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(userName, "USERNAME");
    await preferences.setString(userID, "USERID");
    await preferences.setString(userEmail, "EMAIL");
  }
}
