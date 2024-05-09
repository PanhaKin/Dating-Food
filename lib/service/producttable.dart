import 'package:dating_food/service/model.dart';

class Order {
  final bool complete;
  final List<Product> products;
  final int table;
  final String uid;

  Order({
    required this.complete,
    required this.products,
    required this.table,
    required this.uid,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['product'];
    List<Product> products = productsJson
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return Order(
      complete: json['complete'],
      products: products,
      table: json['table'],
      uid: json['uid'],
    );
  }
}
