import 'package:get/get.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://nestjs-pruebatecnica.herokuapp.com';
  }


  Future<Response> getProducts(String token) => get('/product/all',headers: {
    'Authorization': 'Bearer $token',
  });

  Future<Response> createProduct(String token, Map data) => post('/product/create', data,headers: {
    'Authorization': 'Bearer $token',
  });

  Future<Response> updateProduct(String token, Map data) => put('/product/update', data, headers: {
    'Authorization': 'Bearer $token',
  });

  Future<Response> deleteProduct(String token, String id) =>
      delete('/product/delete/{id}'.replaceFirst("{id}", id), headers: {
    'Authorization': 'Bearer $token',
  });


}