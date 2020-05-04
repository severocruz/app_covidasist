import 'package:app_covidasist/src/bloc/provider.dart';
import 'package:app_covidasist/src/preferencias/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario(); 
    print(prefs.username);
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${ prefs.username }'),
          Divider(),
          Text('Password: ${ bloc.password }')
        ],
      ),
    );
  }
}