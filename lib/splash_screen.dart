import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import './screens/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/manwithlaptop.json",
              repeat: false,
            ),
            const Text(
              "WELCOME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset("assets/dogy.json", height: 200)
          ],
        ),
        nextScreen: HomePage(),
        backgroundColor: Colors.deepPurple,
        splashIconSize: double.infinity,
        duration: 3000,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: const Duration(seconds: 3),
      ),
    );
  }
}
