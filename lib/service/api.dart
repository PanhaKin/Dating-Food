import 'dart:convert';
import 'package:dating_food/service/model.dart';
import 'package:dating_food/service/producttable.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

String baseUrl = "https://panha123.pythonanywhere.com/products";
String baseUrTable = 'https://panha123.pythonanywhere.com/table';
Future<List<Product>> fetchProductFood() async {
  final response = await http.get(Uri.parse('$baseUrl/food'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Product> products =
        data.map((json) => Product.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProductDrink() async {
  final response = await http.get(Uri.parse('$baseUrl/drink'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Product> products =
        data.map((json) => Product.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> fetchProductBread() async {
  final response = await http.get(Uri.parse('$baseUrl/bread'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Product> products =
        data.map((json) => Product.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<void> postData(List<Product> products, int table) async {
  String endpoint = 'https://panha123.pythonanywhere.com/table';
  List<Map<String, dynamic>> productDataList = products.map((product) {
    return {
      'name': product.name,
      'price': product.price,
      'photo': product.photo,
      'uid': Uuid().v4(),
    };
  }).toList();
  final Map<String, dynamic> data = {
    "table": table,
    "complete": false,
    "uid": Uuid().v4(),
    "product": productDataList,
  };
  final String jsonData = jsonEncode(data);
  try {
    final http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );
    if (response.statusCode == 201) {
      print('Data created successfully');
    } else {
      print('Failed to create data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error creating data: $error');
  }
}

Future<List<Order>> fetchFoodOrder() async {
  final response = await http.get(Uri.parse('$baseUrTable/order'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<Order> products =
        data.map((json) => Order.fromJson(json)).toList();
    return products;
  } else {
    throw Exception('Failed to load products');
  }
}
