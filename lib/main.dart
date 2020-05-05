import 'package:app_covidasist/src/bloc/provider.dart';
import 'package:app_covidasist/src/pages/home_page.dart';
import 'package:app_covidasist/src/pages/login_page.dart';
import 'package:app_covidasist/src/preferencias/preferencias_usuario.dart';
import 'package:flutter/material.dart';


void main() async{
  runApp(MyApp());
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CovidAsist',
        initialRoute: 'home',
        routes: {
          'login': ( BuildContext context ) => LoginPage(),
          'home':  ( BuildContext context ) => HomePage(),
        },
      )
    );
    
    
  }
}