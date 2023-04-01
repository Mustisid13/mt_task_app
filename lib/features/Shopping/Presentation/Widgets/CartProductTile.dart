import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';

class CartProductTile extends GetView<ProductsController> {
  const CartProductTile({super.key, required this.productData});
  final ProductData productData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(15),
          color: AppColors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child:
                CachedNetworkImage(imageUrl: productData.featuredImage ?? ""),
          )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    productData.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Price:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        productData.price.toString() + " Rs",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantity:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        productData.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          // padding: EdgeInsets.all(0),
                          onTap: () async {
                            await controller.removeProductFromCart(productData);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
