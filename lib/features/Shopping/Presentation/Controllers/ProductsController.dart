import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Network/ServerExceptions.dart';
import 'package:mt_task_app/core/Styles/AppColors.dart';
import 'package:mt_task_app/core/Utils/snackbar.dart';
import 'package:mt_task_app/features/Shopping/Data/CartDataHandler.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';
import 'package:mt_task_app/features/Shopping/Domain/ProductUsecase.dart';

class ProductsController extends GetxController {
  late ProductUsecase _productUsecase;
  late CartDataHandler _cartDataHandler;
  ProductsController(
      {required ProductUsecase productUsecase,
      required CartDataHandler cartDataHandler}) {
    _productUsecase = productUsecase;
    _cartDataHandler = cartDataHandler;
  }

  late ScrollController scrollController;

  @override
  void onInit() async {
    scrollController = ScrollController();

    await fetchProducts();
    await getCartProducts();
    super.onInit();
  }

  RxBool isLoading = false.obs;

  RxList<ProductData> productsList = <ProductData>[].obs;
  RxList<ProductData> cartProducts = <ProductData>[].obs;

  int perPage = 5;
  int currentPage = 1;
  int totalpages = 1;

  // fetching data from api

  Future<void> fetchProducts() async {
    isLoading.value = true;
    // where we store response
    late Either<ServerExceptions, ProductsResponseModel> result;

    // if we are calling the api for first time
    if (currentPage == 1 && productsList.isEmpty) {
      result = await _productUsecase.fetchProducts();
      result.fold((l) => showGetSnackbar(message: l.message, isError: true),
          (response) {
        productsList.value = response.data ?? [];
        totalpages = response.totalPage ?? totalpages;
      });
    }
    // if we are calling api for multiple times
    // check if current page does not exceed total page
    else if (currentPage + 1 < totalpages) {
      result = await _productUsecase.fetchProducts(
          perPage: perPage, page: currentPage + 1);
      result.fold((l) => showGetSnackbar(message: l.message, isError: true),
          (response) {
        productsList.addAll(response.data ?? []);
        currentPage += 1;
      });
    }
    isLoading.value = false;
  }

  // add product to cart
  Future<void> addProductToCart(ProductData productData) async {
    isLoading.value = true;
    // check if product already in cart
    if (cartContainsProduct(productData.id)) {
      // then only increment it's quantity
      await incrementCartProductCount(productData);
      isLoading.value = false;
      return;
    }
    // if new product is added to cart
    productData.quantity = 1;
    final result = await _cartDataHandler.insert(productData);

    result.fold((l) => showGetSnackbar(message: l.message, isError: true),
        (r) async {
      await getCartProducts();
      showGetSnackbar(
        message: r,
        isError: false,
      );
    });
    isLoading.value = false;
  }

// check if cart contains this product
  bool cartContainsProduct(int? id) {
    return cartProducts.firstWhereOrNull((element) => element.id == id) != null;
  }

  // increment product count
  Future<void> incrementCartProductCount(ProductData productData) async {
    // update prodcut value ion cart
    final rowsAffected = await _cartDataHandler.incrementQuantity(productData);
    // if rowsAffectd are zero then prodcut is not updated
    if (rowsAffected == 0) {
      showGetSnackbar(message: "Unable to add product to cart", isError: true);
    } else {
      showGetSnackbar(
        message: "Successfully added to cart",
      );
      await getCartProducts();
    }
  }

// fetches all the products from local database
  Future<void> getCartProducts() async {
    isLoading.value = true;
    cartProducts.value = await _cartDataHandler.getAllProducts();
    isLoading.value = false;
  }

  Future<void> removeProductFromCart(ProductData productData) async {
    if (productData.id != null) {
      // if quantity of product is more than 1 then we will remove decrement count by one
      if (productData.quantity != null && productData.quantity! > 1) {
        await decrementCartProductCount(productData);
        isLoading.value = false;
        return;
      }

      int rowAffected = await _cartDataHandler.delete(productData.id!);
      if (rowAffected == 0) {
        showGetSnackbar(message: "Cannot remove product", isError: true);
      } else {
        await getCartProducts();
      }
    } else {
      showGetSnackbar(message: "Cannot remove product", isError: true);
    }
  }

  Future<void> decrementCartProductCount(ProductData productData) async {
    // update prodcut value ion cart
    final rowsAffected = await _cartDataHandler.decrementQuantity(productData);
    // if rowsAffectd are zero then prodcut is not updated
    if (rowsAffected == 0) {
      showGetSnackbar(
          message: "Unable to remove product from cart", isError: true);
    } else {
      await getCartProducts();
    }
  }
}
