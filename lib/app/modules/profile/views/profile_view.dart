import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            controller.logout();
          },
          color: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minWidth: MediaQuery.of(context).size.width *0.8,
          elevation: 0,
          child: Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
