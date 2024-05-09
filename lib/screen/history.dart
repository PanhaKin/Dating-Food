import 'package:dating_food/screen/detailstable.dart';
import 'package:dating_food/service/api.dart';
import 'package:dating_food/service/producttable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Order> _product = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    try {
      final product = await fetchFoodOrder();
      setState(() {
        isLoading = false;
        _product = product;
      });
    } catch (error) {
      // Handle error
      print('Error fetching products: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfffe813a),
        title: const Center(
          child: Text(
            "History",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: isLoading
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: height / 1.2,
                    width: width,
                    decoration: const BoxDecoration(),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                            height: 10); // Adjust the height as needed
                      },
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: _product.length,
                      itemBuilder: (context, index) {
                        if (_product.isNotEmpty) {
                          var order = _product[index];
                          if (order.products.isNotEmpty) {
                            return InkWell(
                              onTap: () {
                                Get.to(DetailsTable(
                                  table: order.table,
                                  order: order.products,
                                ));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                height: height / 14,
                                width: width,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffe813a),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Table",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${order.table}",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              color: Color(0xfffe813a),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return const SizedBox(); // Return an empty SizedBox if there's no data
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
