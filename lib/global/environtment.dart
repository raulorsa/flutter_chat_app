

import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid 
    ? 'http://10.0.2.2:3000/api'
    //? 'http://192.168.1.156:3000'
    : 'http://localhost:3000/api';

  static String socketUrl = Platform.isAndroid 
    ? 'http://10.0.2.2:3000'
    //? 'http://192.168.1.156:3000'
    : 'http://localhost:3000';


}