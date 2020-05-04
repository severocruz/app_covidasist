import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _token = '';

  Future<Map<String, dynamic>> login (String email, String password) async {
      // {"userid":"faruni","password":"Inbolsa1"}
       // http://intranet.lafar.net/newApiLafarnet/public/usuario/login
    final authData = {
      'userid'    : email,
      'password'  : password
    };

    final resp = await http.post(
      'http://intranet.lafar.net/newApiLafarnet/public/usuario/login',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

  }
}