import 'dart:convert';

import 'package:chat_app/global/environtment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
  this._autenticando = valor;
  notifyListeners();}


  //Getters del soken
  static Future<void> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }


  Future<bool> login( String email, String password) async {
    this.autenticando = true; 


    final data = {
      'email' : email,
      'password' : password
    };

    final resp = await http.post('${Environment.apiUrl}/login', 
      body: jsonEncode(data),
      headers:{
        'Content-Type': 'application/json'

      }
    );

    this.autenticando = false;
    if (resp.statusCode==200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
    //print(resp.body);
  }


  Future register( String nombre, String email, String password) async {
    this.autenticando = true; 


    final data = {
      'nombre' : nombre, 
      'email' : email,
      'password' : password
    };

    final resp = await http.post('${Environment.apiUrl}/login/new', 
      body: jsonEncode(data),
      headers:{
        'Content-Type': 'application/json'

      }
    );

  //Boton de autenticando
    this.autenticando = false;
    if (resp.statusCode==200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
    //print(resp.body);
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    //Validacion

     final resp = await http.get('${Environment.apiUrl}/login/renew', 
      headers:{
        'Content-Type': 'application/json',
        'x-token': token

      }
    );

  //Boton de autenticando
    this.autenticando = false;
    if (resp.statusCode==200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      this._guardarToken(loginResponse.token);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken ( String token) async {
    return await _storage.write(key: 'token', value: token);


  }

  Future logout() async {
    await _storage.delete(key: 'token');
    
  }
}

