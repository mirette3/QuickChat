import 'package:chat_app/view/screens/chat_screen.dart';
import 'package:chat_app/view/screens/signin_screen.dart';
import 'package:chat_app/view/screens/signup_screen.dart';
import 'package:chat_app/view/screens/splash.dart';
import 'package:chat_app/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({Key? key}) : super(key: key);
final _auth=FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: WelcomeScreen(),
      initialRoute: _auth.currentUser != null ? "chat_screen":"splash_screen" ,
      routes: {
        "welcome_screen" : (context)=>WelcomeScreen(),
        "signin_screen" : (context)=>SignInScreen(),
        "splash_screen" : (context)=>SplashSceen(),
        "signout_screen" : (context)=>SignUpScreen(),
        "chat_screen" : (context)=>ChatScreen(),

      },
    );
  }
}
