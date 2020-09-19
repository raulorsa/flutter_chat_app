import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [
  ];

  bool _estaEscribiendo = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.white,
        title: Column(children: [
        CircleAvatar(child: Text('Te', style: TextStyle(fontSize: 12)),
        backgroundColor: Colors.blue[100],

        maxRadius: 14,
        ),
        SizedBox(height:3),
        Text('Matilda Boba', style: TextStyle(color: Colors.black87, fontSize: 12),)
      ],),
      centerTitle: true,
      elevation: 1,

      ),
      body: Container(
        child: Column(children: [
          Flexible(
            child:ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, i){
                //return Text('$i');
                return _messages[i];
              }),),

              Divider(height: 1,),

              Container(
                height: 
                50,
                color: Colors.white,
                child: _inputChat(),

              )


        ],),
      ),
      
    );
  }

  //PArte de la pantalla del chat de escritura
  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Flexible(
            child: TextField(
              controller: _textController,
              
              onChanged: (String texto){
                setState(() {
                  if (texto.trim().length >0 ){
                    _estaEscribiendo= true;}
                  else{_estaEscribiendo=false;}
                });
              },
              onSubmitted: _handleSubmit ,
              decoration: InputDecoration.collapsed(
                hintText: 'EnviarMensaje'
              ),
              focusNode: _focusNode,
              )
          ),

          //Boton de Enviar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS ? 
            CupertinoButton(child: Text('Enviar'), 
            onPressed:  (_estaEscribiendo) ? () => _handleSubmit(_textController.text.trim()) : null,
            ):

            Container(margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconTheme(
              data: IconThemeData(color: Colors.blue[400]),
               child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                //icon: Icon(Icons.send, color: Colors.blue[400],),
                icon: Icon(Icons.send,),
              onPressed: (_estaEscribiendo) ? () => _handleSubmit(_textController.text.trim()) :null,),
            )
            )
          ),
        ],)
      ));
  }


  _handleSubmit(String texto){
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),);
    _messages.insert(0,newMessage);
    newMessage.animationController.forward();


    setState(() {
      _estaEscribiendo=false;
    });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    //OFF del socket

    for (ChatMessage message in _messages){
      message.animationController.dispose();
      
    }
    super.dispose();
  }


}