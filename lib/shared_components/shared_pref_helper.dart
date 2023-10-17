import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{

  static SharedPreferences sharedPreferences;

  static init ()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  
 static Future<bool> setThemeMode({@required String key,@required bool value})async{
    return  await sharedPreferences.setBool(key, value);
  }

  static bool getThemeMode({@required String key}){
    return sharedPreferences.getBool(key);
  }

}