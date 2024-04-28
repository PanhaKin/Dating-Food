import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dating_food/screen/homepage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
      childWidget: SizedBox(
        height: 300,
        child: Image.asset("assets/images/logo.png"),
      ),
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 1000),
      onAnimationEnd: () => debugPrint("On Scale End"),
      nextScreen: const HomePage(),
    );
  }
}
