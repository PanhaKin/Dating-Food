// ignore_for_file: unused_field
import 'package:dating_food/components/cardview.dart';
import 'package:dating_food/components/tabview.dart';
import 'package:dating_food/screen/alertscreen.dart';
import 'package:dating_food/screen/oderdetails.dart';
import 'package:dating_food/components/cardview.dart';
import 'package:dating_food/service/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../service/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectIndex = 1;
  late int _count = 0;
  bool isLoading = true;
  List<Product> _productFood = [];
  List<Product> _productDrink = [];
  List<Product> _productBread = [];
  List<Product> _tabProduct = [];
  final numberTable = TextEditingController();
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchAndSetProduct();
    postTableData();
  }

  @override
  void dispose() {
    numberTable.dispose();
    super.dispose();
  }

  void postTableData() async {
    print('Products in _tabProduct: ${_tabProduct.map((e) => e)}');
    String tableText = numberTable.text.trim();
    if (tableText.isNotEmpty) {
      final int? tableNumber = int.tryParse(tableText);
      if (tableNumber != null) {
        await postData(_tabProduct, tableNumber).then((_) {
          Get.to(const AlertScreen());
        }).catchError((error) {
          print('Error posting table data: $error');
        });
      } else {
        print('Invalid table number: $tableText');
      }
    } else {
      print('Table number is empty');
    }
  }

  Future<void> _fetchAndSetProduct() async {
    try {
      final productFoods = await fetchProductFood();
      final productDrinks = await fetchProductDrink();
      final productBreads = await fetchProductBread();
      setState(() {
        isLoading = false;
        _productFood = productFoods;
        _productDrink = productDrinks;
        _productBread = productBreads;
      });
    } catch (error) {
      // Handle error
      print('Error fetching products: $error');
    }
  }

  void _handleCardTap(Product product) {
    if (product != null) {
      setState(() {
        _count++;
        _tabProduct.add(product);
      });
    } else {
      print("Product is null");
    }
  }

  double _updateTotalPrice() {
    for (int i = 0; i < _tabProduct.length; i++) {
      totalPrice += _tabProduct[i].price;
    }
    return totalPrice;
  }

  void _deleteItem(BuildContext context, int index) {
    _tabProduct.removeAt(index);
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xfffe813a)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: width / 3.5,
                        width: width / 3.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.cover)),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(OderDetails(
                            productList: _tabProduct,
                            count: _count,
                            deleteItem: _deleteItem,
                            totalPrice: _updateTotalPrice,
                            onTab: postTableData,
                            numberTable: numberTable,
                          ));
                        },
                        child: Container(
                          height: width / 8,
                          width: width / 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _count.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: width / 6.5,
                            width: width / 6.5,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/food_and_drink.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height / 12,
                            width: width / 2,
                            decoration: const BoxDecoration(),
                            child: const Text(
                              "Dating \nFavorite Foods",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: width / 3,
                        width: width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              _selectIndex == 1
                                  ? "assets/images/main-food.png"
                                  : _selectIndex == 2
                                      ? "assets/images/main-drink.png"
                                      : _selectIndex == 3
                                          ? "assets/images/main-bread.png"
                                          : "assets/images/main-food.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: height / 15,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = 1;
                      });
                    },
                    child: TabView(
                      title: "Foods",
                      image: _selectIndex == 1
                          ? "assets/images/food-active.png"
                          : "assets/images/food-inactive.png",
                      textColor:
                          _selectIndex == 1 ? Colors.white : Colors.black,
                      bgColor: _selectIndex == 1
                          ? const Color(0xfffe813a)
                          : Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = 2;
                      });
                    },
                    child: TabView(
                      title: "Drinks",
                      image: _selectIndex == 2
                          ? "assets/images/drink-active.png"
                          : "assets/images/drink-inactive.png",
                      textColor:
                          _selectIndex == 2 ? Colors.white : Colors.black,
                      bgColor:
                          _selectIndex == 2 ? Color(0xfffe813a) : Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = 3;
                      });
                    },
                    child: TabView(
                      title: "Breads",
                      image: _selectIndex == 3
                          ? "assets/images/bread-active.png"
                          : "assets/images/bread-inactive.png",
                      textColor:
                          _selectIndex == 3 ? Colors.white : Colors.black,
                      bgColor:
                          _selectIndex == 3 ? Color(0xfffe813a) : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  if (_selectIndex == 1)
                    isLoading
                        ? SizedBox(
                            height: height / 5,
                            width: width / 5,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: height / 1.75,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: GridView.builder(
                                itemCount: _productFood.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 300,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  var product = _productFood[index];
                                  return Container(
                                    decoration: const BoxDecoration(),
                                    child: CardView(
                                      price: product.price,
                                      name: product.name,
                                      image: product.photo,
                                      onTap: () {
                                        _handleCardTap(product);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                  else if (_selectIndex == 2)
                    isLoading
                        ? SizedBox(
                            height: height / 5,
                            width: width / 5,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: height / 1.75,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: GridView.builder(
                                itemCount: _productDrink.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 250,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  var product = _productDrink[index];
                                  return Container(
                                    decoration: const BoxDecoration(),
                                    child: CardView(
                                      price: product.price,
                                      name: product.name,
                                      image: product.photo,
                                      onTap: () {
                                        _handleCardTap(product);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                  else if (_selectIndex == 3)
                    isLoading
                        ? SizedBox(
                            height: height / 5,
                            width: width / 5,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: height / 1.75,
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: GridView.builder(
                                itemCount: _productBread.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 250,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  var product = _productBread[index];
                                  return Container(
                                    decoration: const BoxDecoration(),
                                    child: CardView(
                                      price: product.price,
                                      name: product.name,
                                      image: product.photo,
                                      onTap: () {
                                        _handleCardTap(product);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
