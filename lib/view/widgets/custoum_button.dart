import 'package:chat_app/view/constants.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  CustomButton({required this.title, required this.onPressed, required this.textColor,required this.bgColor});

  final String title;
  final Color textColor;
  final Color bgColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),

        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: bgColor,
            padding: EdgeInsets.all(20),
            side: BorderSide(color: purple, width: 3),
            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 5
          ),

          child: Text(title,style: TextStyle(color: textColor,fontSize: 18),),
        ),
    );
  }
}
