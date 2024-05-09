class Product {
  final String uid;
  final String photo;
  final String name;
  final double price;

  Product({
    required this.uid,
    required this.photo,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uid: json['uid'] ?? '',
      photo: json['photo'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0.0,
    );
  }
}
