

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:tres_astronautas/app/data/providers/auth_provider.dart';
import 'package:tres_astronautas/app/data/providers/storage_provider.dart';
import 'package:tres_astronautas/app/data/repositories/auth_repository.dart';

void main (){
  test('Auth Repository verify session', () async {
    Get.testMode = true;
    SharedPreferences.setMockInitialValues({});

    final bindings = BindingsBuilder(() {
      Get.put(StorageProvider());
      Get.put(AuthProvider());
      Get.put(AuthRepository());
    });
    bindings.builder();

    final repository = Get.find<AuthRepository>();
    final response = await repository.verify();
    print(response);

    expect(response, isFalse);

  });




}