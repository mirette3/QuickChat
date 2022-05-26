import 'package:chat_app/view/constants.dart';
import 'package:chat_app/view/widgets/custoum_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  child: Image.asset("assets/images/app_icon.png"),
                ),
                Text(
                  "Quick Chat",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 1,
                      color: primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              textColor: Colors.white,
              bgColor: purple,
              title: "Sign in",
              onPressed: () {
                Navigator.pushNamed(context, "signin_screen");
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                bgColor: Colors.white,
                textColor: purple,
                title: "Sign Up",
                onPressed: () {
                  Navigator.pushNamed(context, "signout_screen");
                })
          ],
        ),
      ),
    );
  }
}
