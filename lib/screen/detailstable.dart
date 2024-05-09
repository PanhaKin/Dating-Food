import 'package:dating_food/components/cardlistviewhistory.dart';
import 'package:dating_food/service/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsTable extends StatelessWidget {
  DetailsTable({
    super.key,
    required this.table,
    required this.order,
  });
  int table;
  List<Product> order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfffe813a),
        title: Center(
          child: Text(
            'Table : $table',
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 24,
            )),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10); // Adjust the height as needed
          },
          itemCount: order.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: CardListViewHistory(
                  price: order[index].price,
                  image: order[index].photo,
                  name: order[index].name),
            );
          },
        ),
      ),
    );
  }
}
