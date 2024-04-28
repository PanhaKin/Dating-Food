import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardView extends StatelessWidget {
  CardView({super.key});
  double price = 3.5;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: width / 2.3,
      width: width / 2.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: width / 3.5,
                width: width / 3.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/main-food.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "\$$price",
                style: const TextStyle(
                  color: Color(0xfffe813a),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rice Recipe\nwith Pork",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: width / 14,
                width: width / 14,
                decoration: const BoxDecoration(
                    color: Color(0xfffe813a),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(
                    child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
