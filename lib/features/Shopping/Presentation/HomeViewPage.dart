// This is the home screen
// All products are listed in this screen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Routing/route_names.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Widgets/ProductTile.dart';

class HomeViewPage extends GetView<ProductsController> {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Mall"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(cartPage);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const _BodyWidget(),
            Obx(
              () => Visibility(
                visible: controller.isLoading.value,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.black.withOpacity(0.3),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BodyWidget extends GetView<ProductsController> {
  const _BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Gridview to list out all products
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(() => GridView.builder(
          controller: controller.scrollController,
          itemCount: controller.productsList.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 15),
          itemBuilder: (context, index) {
            return ProductTile(
              productData: controller.productsList[index],
            );
          }));
    });
  }
}
