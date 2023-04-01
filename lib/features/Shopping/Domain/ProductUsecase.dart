import 'package:dartz/dartz.dart';
import 'package:mt_task_app/core/Network/ServerExceptions.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsChopperClient.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';

class ProductUsecase {
  late ProductsChopperClient _chopperClient;
  ProductUsecase({required ProductsChopperClient productsChopperClient}) {
    _chopperClient = productsChopperClient;
  }

  Future<Either<ServerExceptions, ProductsResponseModel>> fetchProducts(
      {int perPage = 5, int page = 1}) async {
    try {
      final result = await _chopperClient
          .fetchProducts({"page": page, "perPage": perPage});
      if (result.isSuccessful) {
        return Right(result.body!);
      }
      return Left(FetchProductException(
          message: "Error occured while fetching products!"));
    } catch (err) {
      return Left(FetchProductException(message: err.toString()));
    }
  }
}
