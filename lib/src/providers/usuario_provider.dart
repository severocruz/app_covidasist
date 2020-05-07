import 'dart:convert';

import 'package:app_covidasist/src/preferencias/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  
  final String _token = '';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login (String email, String password) async {
      // {"userid":"faruni","password":"Inbolsa1"}
      // http://intranet.lafar.net/newApiLafarnet/public/usuario/login
    final authData = {
      'userid'    : email.trim(),
      'password'  : password
    };

    final resp = await http.post(
      'http://intranet.lafar.net/newApiLafarnet/public/usuario/login',
      body: authData//json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    // print("la respuesta de la peticion ${email.trim()}-$password  ---> ${decodedResp['status']}");
    
    if (decodedResp['status'] == 202) {
      _prefs.username = decodedResp['body'][0]['username'].toString();
      print(decodedResp['body']);
      return { 'ok': true, 'username': decodedResp['body'][0]['username'].toString()};
      
    } else {
      return { 'ok': false, 'message': 'Las credenciales son incorrectas'};
    }
  }
}