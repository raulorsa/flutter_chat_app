import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({Key key, @required this.texto, @required this.uid, @required this.animationController}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
        child: this.uid =='123'
        ? _myMessage()
        :_notMyMessage(),
        
      ),
          ),
    );
  }


  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 3, right: 4, left: 40),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration( color: Color(0xff4D9EF6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.05),offset: Offset(0, 5), )],
          ),
        child: Text(this.texto, style: TextStyle(color: Colors.white,),)
      )
    );

  }

  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 3, right: 40, left: 4),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration( color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.05),offset: Offset(0, 5), )],
          ),
        child: Text(this.texto, style: TextStyle(color: Colors.black),)
      )
    );

  }
}