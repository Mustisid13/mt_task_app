import 'package:chopper_client_wrapper/ChopperService/Utils/Convertors/JsonToTypeConverter.dart';
import 'package:chopper/src/base.dart';
import 'package:chopper_client_wrapper/chopper_client_wrapper.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsChopperClient.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';

class AppChopperClient extends ChopperClientWrapper {
  @override
  // TODO: implement baseUrl
  String get baseUrl =>
      "http://205.134.254.135/~mobile/MtProject/public/api/product_list.php";

  @override
  List<ChopperService> get chopperServices => [ProductsChopperClient.create()];

  @override
  String getToken() {
    return "";
  }

  @override
  Map<String, String> getHeaderParameters() {
    return {
      "token":
          "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
    };
  }

  @override
  Map<Type, JsonConvertorFunction> get jsonToErrorModelConvertorMap => {};

  @override
  Map<Type, JsonConvertorFunction> get jsonToModelConvertorMap =>
      {ProductsResponseModel: ProductsResponseModel.fromJson};
}
