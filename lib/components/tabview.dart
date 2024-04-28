import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  TabView(
      {super.key,
      required this.title,
      required this.image,
      required this.textColor,
      required this.bgColor});
  String title;
  String image;
  Color textColor;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      height: MediaQuery.of(context).size.height / 15,
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, color: textColor, fontWeight: FontWeight.normal),
          ),
          Container(
            height: MediaQuery.of(context).size.width / 12,
            width: MediaQuery.of(context).size.width / 12,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
