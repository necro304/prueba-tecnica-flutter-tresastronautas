


import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends GetxService {

  SharedPreferences? prefs;


  write(String key, String value) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs?.setString(key, value);
  }

  read(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs?.getString(key);
  }

  remove(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    await prefs?.remove(key);
  }

}