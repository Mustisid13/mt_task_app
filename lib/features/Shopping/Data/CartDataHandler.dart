import 'package:dartz/dartz.dart';
import 'package:mt_task_app/core/Network/ServerExceptions.dart';
import 'package:mt_task_app/features/Shopping/Data/ProductsResponseModel.dart';
import 'package:sqflite/sqflite.dart';

class CartDataHandler {
  late Database db;

  CartDataHandler() {
    Future.delayed(Duration.zero, () async {
      var databasesPath = await getDatabasesPath();
      String path = "$databasesPath/cart.db";
      await open(path);
    });
  }

  Future<void> open(String path) async {
    // Delete the database
    // await deleteDatabase(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table Cart ( 
  id integer primary key autoincrement, 
  title text not null,
  price integer not null,
  slug string not null,
  description string not null,
  featured_image string not null,
  quantity int not null
  )
''');
    });
  }

  Future<Either<ServerExceptions, String>> insert(
      ProductData productData) async {
    try {
      final result = await db.insert("Cart", productData.toJson());
      if (result == 0) {
        return Left(AddToLocalException(message: "Something went wrong!"));
      }
      return Right("Successfully added to cart");
    } catch (err) {
      return Left(AddToLocalException(message: err.toString()));
    }
  }

  Future<List<ProductData>> getAllProducts() async {
    List<Map<String, dynamic>> maps = await db.query("Cart");
    return maps.map((e) => ProductData.fromJson(e)).toList();
  }

  Future<int> incrementQuantity(ProductData product) async {
    try {
      product.quantity = (product.quantity ?? 0) + 1;
      return await db.update("Cart", product.toJson(),
          where: 'id = ?', whereArgs: [product.id]);
    } catch (err) {
      return 0;
    }
  }

  Future<int> decrementQuantity(ProductData product) async {
    try {
      product.quantity = (product.quantity ?? 0) - 1;
      return await db.update("Cart", product.toJson(),
          where: 'id = ?', whereArgs: [product.id]);
    } catch (err) {
      return 0;
    }
  }

  Future<int> delete(int id) async {
    return await db.delete('Cart', where: 'id = ?', whereArgs: [id]);
  }
}
