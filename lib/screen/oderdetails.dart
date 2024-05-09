import 'package:dating_food/components/cardlistview.dart';
import 'package:dating_food/screen/alertscreen.dart';
import 'package:dating_food/service/api.dart';
import 'package:dating_food/service/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OderDetails extends StatefulWidget {
  OderDetails({
    super.key,
    required this.productList,
    required this.count,
    required this.deleteItem,
    required this.totalPrice,
    required this.onTab,
    required this.numberTable,
  });
  List<Product> productList;
  int count;
  void Function(BuildContext context, int index) deleteItem;
  double Function() totalPrice;
  void Function() onTab;
  TextEditingController numberTable;
  @override
  State<OderDetails> createState() => _OderDetailsState();
}

class _OderDetailsState extends State<OderDetails> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Card",
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
        ),
        backgroundColor: const Color(0xfffe813a),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 32,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: height / 10,
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color(0xfffe813a),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Table",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: TextFormField(
                            controller: widget.numberTable,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontSize: 24),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Container(
                        height: height / 1.7,
                        width: width,
                        decoration: const BoxDecoration(),
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                                height: 10); // Adjust the height as needed
                          },
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: widget.productList.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(index.toString()),
                              onDismissed: (direction) {
                                widget.deleteItem(context, index);
                              },
                              background: Container(
                                padding: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                              child: CardListView(
                                  image: widget.productList[index].photo,
                                  price: widget.productList[index].price,
                                  name: widget.productList[index].name),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: height / 6.5,
                width: width,
                decoration: const BoxDecoration(color: Color(0xfffe813a)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32),
                        ),
                        Text(
                          "Coming soon",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 28),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: widget.onTab,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            "Confirm Order",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xfffe813a),
                                fontSize: 28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
