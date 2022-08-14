import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:tres_astronautas/app/data/models/auth_model.dart';
import 'package:tres_astronautas/app/data/repositories/auth_repository.dart';


class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  Future<String?> login(LoginData data) async {
    final response = await _authRepository.login(
      email: data.name,
      password: data.password,
    );
    if(response is AuthModel){
      return null;
    }else if(response is String) {
      return response;
    }else{
      return 'error';
    }
  }

  Future<String?> register(SignupData data) async {
    final response = await _authRepository.register(
      email: data.name ?? '',
      password: data.password ?? '',
      name: data.additionalSignupData?['name'] ?? '',
    );
    if(response is AuthModel){
      return null;
    }else if(response is String) {
      return response;
    }else{
      return 'error';
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
