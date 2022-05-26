import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custoum_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

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
              height: 40,
            ),
            TextField(
              onChanged: (value) => email = value,
              textAlign: TextAlign.left,
              obscureText: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email,color: primaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) => password = value,
              textAlign: TextAlign.left,
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.password,color: primaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
              textColor: Colors.white,
              bgColor: purple,
              title: "Sign in",
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, "chat_screen");
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const Text("Don't Have an account ? ",style: TextStyle(fontStyle: FontStyle.italic),),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, "signout_screen");
              }, child: Text("Sign Up",style: TextStyle(color: purple),))
            ],)
          ],
        ),
      ),
    );
  }
}
