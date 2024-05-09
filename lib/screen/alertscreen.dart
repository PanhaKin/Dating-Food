import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dating_food/screen/homepage.dart';
import 'package:dating_food/screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xfffe813a),
          Color(0xfffe813a),
        ],
      ),
      childWidget: Container(
        width: 300,
        height: 500,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Image.asset("assets/images/logo.png"),
            const Text(
              "Order Successfully",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 28),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 1000),
      onAnimationEnd: () => debugPrint("On Scale End"),
      nextScreen: const Navbar(),
    );
  }
}
