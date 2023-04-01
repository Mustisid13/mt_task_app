import 'package:chopper/chopper.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';

part 'ProductsChopperClient.chopper.dart';

@ChopperApi()
abstract class ProductsChopperClient extends ChopperService {
  static ProductsChopperClient create({ChopperClient? client}) =>
      _$ProductsChopperClient(client);

  @Post()
  Future<Response<ProductsResponseModel>> fetchProducts(
      @body Map<String, dynamic> body);
}
