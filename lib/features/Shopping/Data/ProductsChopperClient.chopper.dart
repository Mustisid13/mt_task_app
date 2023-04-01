// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductsChopperClient.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ProductsChopperClient extends ProductsChopperClient {
  _$ProductsChopperClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductsChopperClient;

  @override
  Future<Response<ProductsResponseModel>> fetchProducts(
      Map<String, dynamic> body) {
    final Uri $url = Uri.parse('');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProductsResponseModel, ProductsResponseModel>($request);
  }
}
