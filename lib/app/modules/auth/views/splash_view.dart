import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tres_astronautas/app/modules/auth/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            SizedBox(height: 20),
            Obx(()=>
              controller.loading.value ?  CircularProgressIndicator(
                color: Colors.indigo,
              ): SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
