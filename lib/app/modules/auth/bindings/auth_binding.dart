import 'package:get/get.dart';

import 'package:tres_astronautas/app/modules/auth/controllers/splash_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
