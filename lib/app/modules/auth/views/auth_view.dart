import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: "assets/logo.png",
      theme: LoginTheme(
        pageColorLight: Colors.white,
        accentColor: Colors.blueGrey,
        primaryColor: Colors.blueAccent,
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      hideForgotPasswordButton: true,
      userType: LoginUserType.email,

      messages: LoginMessages(
        userHint: 'Correo electrónico',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar contraseña',
        loginButton: 'Ingresar',
        signupButton: 'Registrarse',
        forgotPasswordButton: 'Olvidé mi contraseña',
        recoverPasswordButton: 'Recuperar contraseña',
        goBackButton: 'Volver',
        confirmPasswordError: 'Las contraseñas no coinciden',
        recoverPasswordIntro: 'Introduzca su correo electrónico',
        recoverPasswordSuccess: 'Revise su correo electrónico',
        additionalSignUpFormDescription: 'Por favor, complete el formulario, para registrarse',
        additionalSignUpSubmitButton: 'Registrarse',

      ),
      onLogin: controller.login,
      onSignup: controller.register,
      onSubmitAnimationCompleted: () {
        Get.offAllNamed(Routes.HOME);
      },
      additionalSignupFields: const [
        UserFormField(keyName: 'name', displayName: 'Nombre', icon: Icon(Icons.person), ),
      ],
      hideProvidersTitle: false,
      userValidator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Correo electrónico requerido';
        }
        if(!GetUtils.isEmail(value)) {
          return "Correo electrónico inválido";
        }
        return null;
      },
      passwordValidator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Contraseña requerida';
        }
        if (value.length <= 6) {
          return 'Contraseña demasiado corta';
        }
        return null;
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
