import 'package:get/get.dart';
import 'package:tres_astronautas/app/data/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

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


  void logout() {
    _authRepository.logout();
  }
}
