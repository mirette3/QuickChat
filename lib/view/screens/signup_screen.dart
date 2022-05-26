import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../widgets/custoum_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth= FirebaseAuth.instance;

  late String userEmail;
  late String userPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
          SizedBox(
            height: 40,
          ),
          TextField(
            onChanged: (value) => userEmail = value,
            textAlign: TextAlign.left,
            obscureText: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your email",
              prefixIcon: Icon(Icons.email,color: primaryColor),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            onChanged: (value) => userPassword= value,
            textAlign: TextAlign.left,
            obscureText: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your password",
              prefixIcon: Icon(Icons.password,color: primaryColor),
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        CustomButton(
          textColor: Colors.white,
          bgColor: purple,
          title: "Sign Up",
          onPressed: () async {
            // print(email);
            // print(password);
            try{
              final newuser = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
              Navigator.pushNamed(context, "chat_screen");

            }catch(e){
              print(e);
            }
          },
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Have an account ? ",style: TextStyle(fontStyle: FontStyle.italic),),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, "signin_screen");
              }, child: Text("Sign in",style: TextStyle(color: purple),))
            ],)


        ],),
    ),);
  }
}
