import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_covidasist/src/models/date_model.dart';

class DateProvider {
  final String _token = '';

  final String _url = 'http://worldtimeapi.org/api/ip/181.188.161.127';
  
  Future<Map<String, dynamic>> obtenerFechaYHoraActual() async{
    final response = await http.get(_url);
    Map<String, dynamic> decodedResp = json.decode(response.body);
    
    // print(decodedResp);
    return { 'fecha': decodedResp['datetime'] };
  }
}