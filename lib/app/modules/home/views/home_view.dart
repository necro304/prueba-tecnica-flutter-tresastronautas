import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tres_astronautas/app/modules/home/widgets/item_product_widget.dart';
import 'package:tres_astronautas/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((state) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.openModal(false, null);

            },
          ),
          actions: [
            IconButton(
                onPressed: (){
                  Get.toNamed(Routes.PROFILE);
                },
                icon: Icon(Icons.person)
            ),
          ],
        ),
        body: Obx(()=>
            AnimatedList(
              key: controller.listKey,
              initialItemCount: controller.products.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index, animation) {
                final product = controller.products[index];
                return ItemProductWidget(
                    index: index,
                    product: product,
                    onTapUpdate: (){
                      controller.openModal(true, index);
                    },
                    onTapDelete: (){
                      controller.remove(index: index);
                    },
                    animation: animation
                );

              },
            ),
        ),
      )),
    );
  }


}
