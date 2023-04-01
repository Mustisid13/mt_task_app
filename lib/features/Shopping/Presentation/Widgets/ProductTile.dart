import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';

class ProductTile extends GetView<ProductsController> {
  const ProductTile({super.key, required this.productData});
  final ProductData productData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(15),
          color: AppColors.grey),
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: productData.featuredImage ?? "",
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.error,
                      color: AppColors.primaryColor,
                    );
                  },
                ),
              )),
          Flexible(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        productData.title ?? "",
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                          onTap: () async {
                            await controller.addProductToCart(productData);
                          },
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            color: AppColors.primaryColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
