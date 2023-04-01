import 'package:get/get.dart';
import 'package:mt_task_app/core/Network/AppChopperClient.dart';
import 'package:mt_task_app/features/Shopping/Data/CartDataHandler.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsChopperClient.dart';
import 'package:mt_task_app/features/Shopping/Domain/ProductUsecase.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/ProductsController.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // initializing our chopper client
    Get.lazyPut(() => AppChopperClient());
    // initializing cart local database
    Get.lazyPut(() => CartDataHandler());

    // inititalizing Product usecase
    Get.lazyPut(() => ProductUsecase(
        productsChopperClient: Get.find<AppChopperClient>()
            .getChopperService<ProductsChopperClient>()));
    // initializing products controller
    Get.lazyPut(() => ProductsController(
        productUsecase: Get.find(), cartDataHandler: Get.find()));
  }
}
