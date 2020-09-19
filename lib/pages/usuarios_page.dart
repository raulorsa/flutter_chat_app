import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =  RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Juan', email: 'test2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Fernando', email: 'test3@test.com', online: true)
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.exit_to_app, color: Colors.black), 
        onPressed: (){},),
      actions: [
        Container(margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.check_circle, color: Colors.blue[400]),
        )

      ],),


      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
      child: _listViewUsuarios()),
      
      
      
      );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) {
        return _usuarioListTile(usuarios[i]);
      },
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(usuario) {
    return ListTile( title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[200],
          child: Text(usuario.nombre.substring(0,2))),
        trailing: Container(width: 10,
        height: 10,
        decoration: BoxDecoration(color: usuario.online ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(100)),),
        
        );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();

  }
}