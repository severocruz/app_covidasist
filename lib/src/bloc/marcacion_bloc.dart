import 'dart:async';

import 'package:app_covidasist/src/models/marcacion_model.dart';
import 'package:app_covidasist/src/providers/db_provider.dart';

class MarcacionBloc {

  static final MarcacionBloc _singleton = new MarcacionBloc._internal();

  factory MarcacionBloc(){

  }

  MarcacionBloc._internal(){
    // Obtener las marcaciones de la base de datos
    obtenerMarcaciones('faruni');
  }

  final _marcacionController = StreamController<List<Marcacion>>.broadcast();

  Stream<List<Marcacion>> get marcacionStream => _marcacionController.stream;


  dispose(){
    _marcacionController?.close();
  }

  obtenerMarcaciones(String username) async {
    _marcacionController.sink.add( await DBProvider.db.getMarcacionesPorUsername(username));
  }

  agregarMarcacion(Marcacion marcacion) async{
    await DBProvider.db.nuevaMarcacion(marcacion);
    obtenerMarcaciones('faruni');
    
  }
}