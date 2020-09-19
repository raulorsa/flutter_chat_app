import 'dart:ffi';

import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:chat_app/widgets/custiom_input.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
          Logo(titulo: 'Messenger'),
          _Form(),
          Labels(texto1: '¿No tienes cuenta?', texto2: 'Crea una ahora!', ruta: 'register',),
          Text('Terminos y Condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),),
        ],),
                  ),
              ),
      )
      
    );
  }
}





class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        child: Column(
          children: [
            CustomInput(textController: emailCtrl, icon: Icons.mail_outline, placeholder: 'Email',),
            CustomInput(textController: passCtrl, icon: Icons.lock_outline, placeholder: 'Password', isPassword: true),

            SizedBox(height: 20,),

            BotonAzul(texto: 'Entrar', onPressed: (){},),

          ],
        ),
        
      ),
    );
  }
}


