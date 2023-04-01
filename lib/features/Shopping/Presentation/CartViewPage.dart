import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Widgets/CartFooterWidget.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Widgets/CartProductTile.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';

class CartViewPage extends GetView<ProductsController> {
  const CartViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Stack(
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
    );
  }
}

class _BodyWidget extends GetView<ProductsController> {
  const _BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OrientationBuilder(builder: (context, orientation) {
            return Obx(() => GridView.builder(
                itemCount: controller.cartProducts.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                    childAspectRatio: 2.2),
                itemBuilder: (context, index) {
                  return CartProductTile(
                    productData: controller.cartProducts[index],
                  );
                }));
          }),
        ),
        // displaystotal count and grand total
        const CartFooterWidget()
      ],
    );
  }
}
