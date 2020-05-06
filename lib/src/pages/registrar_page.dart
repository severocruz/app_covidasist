import 'dart:async';
import 'dart:io';

import 'package:app_covidasist/src/providers/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  File foto;
  String tipoMapa = 'streets';

  double size;

  final dateProvider = new DateProvider();
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size.height;
    
    new Timer.periodic(new Duration(seconds: 20), this._obtenerFechaActual());
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Container(
         height: this.size * 0.5,
         child: Column(
          children: <Widget>[
            _capturaDatos(context),
            Divider(),  
            _creatReloj(),
            Divider(),
            _crearBotones(context)
           ],
         ),
       ),
        _crearFlutterMap(),
      ],
    );
  }

  Widget _creatReloj() {
    return Column(
     children: <Widget>[
       Text('19:50:02', 
            style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold ),
       ),
       Container(width:double.infinity),
       Text('20/03/2020',
            style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w300 ),
       )
    ],
   );
 }

  Widget _crearBotones(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              obtenerImagen();
            }, 
            child: Text('Registrar Entrada'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            ),
          RaisedButton(
            onPressed: (){}, 
            child: Text('Registrar Salida'),
            color: Colors.redAccent,
            textColor: Colors.white
          ),
        ],
      );
  }

  Widget _capturaDatos(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10.0),
          // padding: EdgeInsets.only(top: 20.0),
          width: 90.0,
          height: 90.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: _mostrarFoto()
              // image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTJyGP6-PJuOHSQF-tpSPRouWwo3HvXp2bV93IssX8I7h5VLeTk&usqp=CAU')
            )
          ),
        ),
        Text('Hora de Entrada: 08:25:03'),
        Text('Hora de Salida: 16:30:03'),
      ],
    );
  }

  _obtenerFechaActual(){
    setState(() {
      this.dateProvider.obtenerFechaYHoraActual();
    });
  }
    

  _mostrarFoto() {
    if (foto != null) {
      return FileImage(foto);
    } else {
      return AssetImage('assets/no-image.png');
    }
  }

  Future obtenerImagen() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    
    if(foto != null){
      // limpieza
    }

    setState(() {
      foto = image;
    });
  }

  Widget _crearFlutterMap(){
    return Container(
      width: double.infinity,
      height: this.size*0.25,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(-16.5454941,-68.2310343),
          zoom: 15
        ),
        layers: [
          _crearMapa(),          
        ],
      ),
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'http://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZmFydW5pIiwiYSI6ImNrOWdrbWkyYzBua2MzZ25hdzh5bnk4OWwifQ.ossB1NDZUOo32qxTlQDMNA',
        'id': 'mapbox.$tipoMapa'
        //streets, dark, light, outdoors, satellite
      }
    );
  }
}