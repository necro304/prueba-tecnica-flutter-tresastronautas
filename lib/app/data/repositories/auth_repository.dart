


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tres_astronautas/app/data/providers/storage_provider.dart';
import 'package:tres_astronautas/app/routes/app_pages.dart';

import '../models/auth_model.dart';
import '../providers/auth_provider.dart';

class AuthRepository  extends GetxService {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  Future login({required String email, required String password}) async {
    try{
      final response = await _authProvider.login({
        'email': email,
        'password': password,
      });
      if (kDebugMode) {
        print("response.body");
        print(response.body);
      }
      if(response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created){

        final model = AuthModel.fromJson(response.body);
        _storageProvider.write('auth', authToJson(model));
        return model;
      }else{
        return response.body['message'];
      }

    }catch(e){
      if (kDebugMode) {
        print("error: $e");
      }
      return "error";
    }


  }

  Future register({required String email, required String password, required String name}) async {
    try{
      final response = await _authProvider.register({
        'email': email,
        'password': password,
        'name': name,
      });
      if (kDebugMode) {
        print("response.body");
        print(response.body);
      }
      if(response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created){

        final model = AuthModel.fromJson(response.body);
        _storageProvider.write('auth', authToJson(model));
        return model;
      }else{
        return response.body['message'];
      }

    }catch(e){
      if (kDebugMode) {
        print("error: $e");
      }
      return "error";
    }


  }

  Future<bool> verify() async {
    try {
      final res = await _storageProvider.read('auth');

      if (kDebugMode) {
        print("res");
        print(res);
      }
      if (res == null) {
        return false;
      }
      final model = authFromJson(res);

      final response = await _authProvider.verify(model.token);
      if (kDebugMode) {
        print("response.body");
        print(response.body);
      }
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
      return false;
    }
  }

  Future logout() async {
    await _storageProvider.remove('auth');
    Get.offAllNamed(Routes.SPLASH);
  }



}