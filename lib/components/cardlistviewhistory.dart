import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardListViewHistory extends StatelessWidget {
  CardListViewHistory(
      {super.key,
      required this.price,
      required this.image,
      required this.name});
  double price;
  String image;
  String name;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: height / 9,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xfffe813a),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: width / 5,
            width: width / 5,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width / 10),
              image: DecorationImage(
                image: NetworkImage(image),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                "\$$price",
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
