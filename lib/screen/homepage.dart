// ignore_for_file: unused_field
import 'package:dating_food/components/tabview.dart';
import 'package:dating_food/screen/foodscreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Column(
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
                    Container(
                      height: width / 8,
                      width: width / 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "0",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                    textColor: _selectIndex == 1 ? Colors.white : Colors.black,
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
                    textColor: _selectIndex == 2 ? Colors.white : Colors.black,
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
                    textColor: _selectIndex == 3 ? Colors.white : Colors.black,
                    bgColor:
                        _selectIndex == 3 ? Color(0xfffe813a) : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                if (_selectIndex == 1)
                  Container(
                    height: height / 1.75,
                    width: double.infinity,
                    child: const FoodScreen(),
                  )
                else if (_selectIndex == 2)
                  Container(
                    height: height / 1.75,
                    width: double.infinity,
                    color: Colors.red,
                  )
                else if (_selectIndex == 3)
                  Container(
                    height: height / 1.75,
                    width: double.infinity,
                    color: Colors.blue,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
