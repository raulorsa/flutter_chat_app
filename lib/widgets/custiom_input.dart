
import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({Key key, @required this.icon, @required this.placeholder, @required this.textController, this.keyboardType= TextInputType.text, this.isPassword=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top:5, left:5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(prefixIcon: Icon( icon),
        focusedBorder: InputBorder.none,
        hintText: placeholder),
      ));
  }
}