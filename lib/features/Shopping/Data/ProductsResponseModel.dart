class ProductsResponseModel {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<ProductData>? data;

  ProductsResponseModel(
      {this.status, this.message, this.totalRecord, this.totalPage, this.data});

  ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalRecord'] = this.totalRecord;
    data['totalPage'] = this.totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;
  int? quantity;

  ProductData(
      {this.id,
      this.slug,
      this.title,
      this.description,
      this.price,
      this.featuredImage,
      this.quantity,
      this.status,
      this.createdAt});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    // status = json['status'];
    createdAt = json['created_at'];
    quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['featured_image'] = this.featuredImage;
    // data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    data['quantity'] = this.quantity ?? 0;
    return data;
  }
}
