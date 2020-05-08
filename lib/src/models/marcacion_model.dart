import 'dart:convert';

Marcacion marcacionFromJson(String str) => Marcacion.fromJson(json.decode(str));

String marcacionToJson(Marcacion data) => json.encode(data.toJson());

class Marcacion {
    int id;
    String username;
    String nombreEmpleado;
    DateTime fechaMarcacion;
    double latitud;
    double longitud;
    String imagen;
    bool estadoSync;

    Marcacion({
        this.id,
        this.username,
        this.nombreEmpleado,
        this.fechaMarcacion,
        this.latitud,
        this.longitud,
        this.imagen,
        this.estadoSync,
    });

    factory Marcacion.fromJson(Map<String, dynamic> json) => Marcacion(
        id: json["Id"],
        username: json["Username"],
        nombreEmpleado: json["NombreEmpleado"],
        fechaMarcacion: DateTime.parse(json["FechaMarcacion"]),
        latitud: json["Latitud"].toDouble(),
        longitud: json["Longitud"].toDouble(),
        imagen: json["Imagen"],
        estadoSync: json["EstadoSync"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Username": username,
        "NombreEmpleado": nombreEmpleado,
        "FechaMarcacion": fechaMarcacion.toIso8601String(),
        "Latitud": latitud,
        "Longitud": longitud,
        "Imagen": imagen,
        "EstadoSync": estadoSync,
    };
}
