
import 'package:get/get.dart';
import 'package:tres_astronautas/app/data/providers/auth_provider.dart';
import 'package:tres_astronautas/app/data/providers/product_provider.dart';
import 'package:tres_astronautas/app/data/providers/storage_provider.dart';
import 'package:tres_astronautas/app/data/repositories/auth_repository.dart';


class DependencyInjection {
  static void init() {
    // providers
    Get.put<AuthProvider>(AuthProvider());
    Get.put<StorageProvider>(StorageProvider());
    Get.put<ProductProvider>(ProductProvider());


    /// repositories
    Get.put<AuthRepository>(AuthRepository());


  }
}