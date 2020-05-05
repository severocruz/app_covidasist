import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RegistrarPage extends StatelessWidget {
  String tipoMapa = 'streets';
  double size;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size.height;
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Container(
         padding: EdgeInsets.only(top:20.0),
         height: this.size * 0.5,
         child: Column(
          children: <Widget>[
            _capturaDatos(context),
            Divider(),  
            _creatReloj(),
            Divider(),
            _crearBotones(context),
            Divider(),
            
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
            style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300 ),
       )
     ],
   );
 }

  Widget _crearBotones(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(onPressed: (){}, 
            child: Text('Registrar Entrada',style: TextStyle(fontSize: 20),),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            ),
          RaisedButton(onPressed: (){}, 
            child: Text('Registrar Salida',style: TextStyle(fontSize: 20),),
            color: Colors.redAccent,
            textColor: Colors.white,
            
            ),
        ],
      );
  }

  Widget _capturaDatos(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTJyGP6-PJuOHSQF-tpSPRouWwo3HvXp2bV93IssX8I7h5VLeTk&usqp=CAU'),),
        Text('Hora de Entrada: 08:25:03'),
        Text('Hora de Salida: 16:30:03'),
      ],
    );
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