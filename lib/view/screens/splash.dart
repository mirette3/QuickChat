import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashSceen extends StatelessWidget {
  const SplashSceen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Image(
        image: AssetImage("assets/images/app_icon.png"),
        width: 120,
        height: 25,
        fit: BoxFit.cover,
      ),
      nextScreen: const WelcomeScreen(),
      duration: 5,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}
