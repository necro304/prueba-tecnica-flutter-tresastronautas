import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://nestjs-pruebatecnica.herokuapp.com';
  }

  Future<Response> login(Map data) => post('/auth/login', data);

  Future<Response> register(Map data) => post('/auth/register', data);

  Future<Response> verify(String token) => get('/auth-verify',headers: {
    'Authorization': 'Bearer $token',
  });

}
