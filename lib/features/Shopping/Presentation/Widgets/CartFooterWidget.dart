import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';

class CartFooterWidget extends GetView<ProductsController> {
  const CartFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(color: AppColors.secondaryColor),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Items: ${controller.cartProducts.map((element) => element.quantity ?? 0).sum}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white),
            ),
            Text(
              "Grand Total: ${controller.cartProducts.map((prod) => (prod.price ?? 0) * (prod.quantity ?? 0)).sum}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
