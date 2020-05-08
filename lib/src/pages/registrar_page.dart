import 'dart:async';
import 'dart:io';

import 'package:app_covidasist/src/bloc/marcacion_bloc.dart';
import 'package:app_covidasist/src/models/marcacion_model.dart';
import 'package:app_covidasist/src/providers/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  final marcacionBloc = new MarcacionBloc();
  File foto;
  String tipoMapa = 'streets';

  double size;
  String _fechaActual = '';
  String _horaActual = '';

  LatLng _ubicacionActual;
  final dateProvider = new DateProvider();
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size.height;

    this._obtenerUbicacionActual();
    this._obtenerFechaActual();    
    // new Timer.periodic(new Duration(seconds: 20), this._obtenerFechaActual());
    new Timer.periodic(Duration(seconds: 60), (Timer t) => _obtenerFechaActual());
    return SingleChildScrollView(
      child: Column(
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
      ),
    );
  }

  Widget _creatReloj() {
    return Column(
     children: <Widget>[
       Text(
        _horaActual, // != null ? 'No existe la hora' : _fechaActual, 
        style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold ),
       ),
       Container(width:double.infinity),
       Text(
         _fechaActual,
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
            onPressed: () => _registrarSalida(), 
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

  _obtenerFechaActual() async{
    Map info = await this.dateProvider.obtenerFechaYHoraActual(); 
    setState(() {
      var datofecha = info['fecha'].toString();
      var fechaActual = DateTime.parse(datofecha.substring(0, datofecha.length - 6));

      var formatoFecha = new DateFormat('dd-MMM-yyyy');
      var formatoHora = new DateFormat.Hms();
      _fechaActual = formatoFecha.format(fechaActual);
      _horaActual = formatoHora.format(fechaActual);
      // print(fechaActual);
    });
  }
    
  _obtenerUbicacionActual() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _ubicacionActual = new LatLng(position.latitude, position.longitude);
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
          center: _ubicacionActual != null ? _ubicacionActual: LatLng(-16.5454941,-68.2310343),
          zoom: 14
        ),
        layers: [
          _crearMapa(),
          this._ubicacionActual != null 
            ? _crearMarcadores(this._ubicacionActual) : new MarkerLayerOptions()
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

  _crearMarcadores( LatLng ubicacion ){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: ubicacion,
          builder: ( context ) => Container(
            child: 
              Icon(
                Icons.location_on,
                size: 70.0,
                color: Theme.of(context).primaryColor,
              ),
          )
        )
      ]
    );
  }

  _registrarEntrada(){
      final Marcacion marcacion = new Marcacion();
      marcacion.id = 0;
      marcacion.username = 'faruni';
      marcacion.nombreEmpleado = 'Franz Ronald Aruni Mollo';
      marcacion.fechaMarcacion = DateTime.now();
      marcacion.latitud = 1.44323432;
      marcacion.longitud = 1.34234443;
      marcacion.imagen = 'faruni.png';
      marcacion.estadoSync = false;

      marcacionBloc.agregarMarcacion(marcacion);
  }

  _registrarSalida(){
      final Marcacion marcacion = new Marcacion();
      marcacion.id = 0;
      marcacion.username = 'faruni';
      marcacion.nombreEmpleado = 'Franz Ronald Aruni Mollo';
      marcacion.fechaMarcacion = DateTime.now();
      marcacion.latitud = 1.44323432;
      marcacion.longitud = 1.34234443;
      marcacion.imagen = 'faruni.png';
      marcacion.estadoSync = false;

      marcacionBloc.agregarMarcacion(marcacion);
  }
}