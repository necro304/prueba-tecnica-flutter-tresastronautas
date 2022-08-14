import 'package:get/get.dart';
import 'package:tres_astronautas/app/routes/app_pages.dart';

import '../../../data/repositories/auth_repository.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  RxBool loading = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    verify();
    super.onReady();
  }
  Future verify() async {
    Future.delayed(Duration(milliseconds: 600));
    final response = await _authRepository.verify();
    if(response){
      Get.offNamed(Routes.HOME);
    }else{
      Get.offNamed(Routes.AUTH);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

}
