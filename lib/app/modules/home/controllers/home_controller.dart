
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:tres_astronautas/app/data/models/auth_model.dart';
import 'package:tres_astronautas/app/data/providers/product_provider.dart';
import 'package:tres_astronautas/app/data/providers/storage_provider.dart';
import 'package:tres_astronautas/app/modules/home/widgets/item_product_widget.dart';

class HomeController extends GetxController with StateMixin {
  final ProductProvider _productProvider = Get.find<ProductProvider>();
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  RxList<dynamic> products = RxList.empty();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future _getProducts() async {
    final resAuth = await _storageProvider.read('auth');
    final modelAuth = authFromJson(resAuth);
    final resProducts = await _productProvider.getProducts(modelAuth.token);
    products.clear();

    if(resProducts.statusCode == HttpStatus.ok || resProducts.statusCode == HttpStatus.accepted){
      final modelProducts = resProducts.body;
      products.addAll(modelProducts);
    }
  }

  _init() async {
    await _getProducts();
    change(null, status: RxStatus.success());
  }


  @override
  void onReady() {
    _init();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  openModal(bool editProduct, int? index) {
    if(editProduct){
      final product = products[index!];
      nameController.text = product['name'];
      priceController.text = product['price'].toString();
    }else{
      nameController.text = '';
      priceController.text = '';
    }
    Get.dialog(SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      title: Text(editProduct ? 'Editar Producto' : 'Agregar Producto'),
      children: [
        Form(child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                controller: nameController,
                keyboardType: TextInputType.name,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                ),
                controller: priceController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (){
                    if(editProduct){
                      _updateProduct(index!);
                    }else{
                      _addProduct();

                    }
                  },
                  child: Text(editProduct ? 'Editar' : 'Agregar'))
            ],
          )
        ),
      ],

    ));
  }

  remove({required int index, }) async {
    final product = products[index];
    final resAuth = await _storageProvider.read('auth');
    final modelAuth = authFromJson(resAuth);
    final resProduct = await _productProvider.deleteProduct(modelAuth.token, product['_id']);

    if(resProduct.statusCode == HttpStatus.ok || resProduct.statusCode == HttpStatus.accepted || resProduct.statusCode == HttpStatus.created){


      listKey.currentState?.removeItem(
          0, (_, animation) => ItemProductWidget(
          index: index,
          product: product,
          onTapUpdate: (){},
          onTapDelete: (){},
          animation: animation
      ),
          duration: const Duration(milliseconds: 500));
      products.removeAt(index);
    }
  }

  _updateProduct(int index) async {
    if(Get.isDialogOpen ?? false){
      Get.back();
    }
    final resAuth = await _storageProvider.read('auth');
    final modelAuth = authFromJson(resAuth);
    final resProduct = await _productProvider.updateProduct(modelAuth.token, {
      '_id': products[index]['_id'],
      'name': nameController.text,
      'price': int.parse(priceController.text)
    });
    print(resProduct.bodyString);
    if(resProduct.statusCode == HttpStatus.ok || resProduct.statusCode == HttpStatus.created){
      final modelProduct = resProduct.body;
      if(Get.isDialogOpen ?? false){
        Get.back();
      }

      products[index]['name'] = modelProduct['name'];
      products[index]['price'] = modelProduct['price'];
      products.refresh();
    }
  }

  _addProduct() async {
    if(Get.isDialogOpen ?? false){
      Get.back();
    }
    final resAuth = await _storageProvider.read('auth');
    final modelAuth = authFromJson(resAuth);
    final resProduct = await _productProvider.createProduct(modelAuth.token, {
      'name': nameController.text,
      'price': int.parse(priceController.text)
    });
    if(resProduct.statusCode == HttpStatus.ok || resProduct.statusCode == HttpStatus.accepted
        || resProduct.statusCode == HttpStatus.created){

      final modelProduct = resProduct.body;

      listKey.currentState?.insertItem(0,
          duration: const Duration(milliseconds: 500));

      products.insert(0, modelProduct);

      products.refresh();
    }
  }

}
