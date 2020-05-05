import 'package:app_covidasist/src/bloc/provider.dart';
import 'package:app_covidasist/src/pages/listar_page.dart';
import 'package:app_covidasist/src/pages/registrar_page.dart';
import 'package:app_covidasist/src/preferencias/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pagActual = 0;

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario(); 
    
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Asist'),
      ),
      body: _callPage(pagActual),
      bottomNavigationBar: _crearBotonNaviagationBar(),
    );
  }

 Widget _crearBotonNaviagationBar() {
   return BottomNavigationBar(
     currentIndex: pagActual,
     items: [
       BottomNavigationBarItem(
         icon: Icon(Icons.assignment_ind),
         title: Text('Marcar')
         ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('Historial')
        )
     ],
     
     onTap: (index){

       setState(() {
         pagActual=index;

       });
     },

   );
 }

 Widget _callPage(int paginaActual) {
    switch(paginaActual){
      case 0: return RegistrarPage();
      case 1: return ListarPage();

      default: return RegistrarPage();
    }
  }
}