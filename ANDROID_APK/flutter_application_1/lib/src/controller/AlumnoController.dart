import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlumnoController {

  Future<http.Response> CrearAlumno(
    String nombreController,
    String apellidoController,
    String dniController,
    String codigoController,
    String correoController,
    String fotoController,
    // String created_atController,
    // String updated_atController,
  ) async {


    Map data = {
      'nombre': '$nombreController',
      'apellido': '$apellidoController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'correo': '$correoController',
      'foto': '$fotoController',
      // 'created_at': '$created_atController',
      // 'updated_at': '$updated_atController',
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(ConfigApi.buildUrl('/alumno')),
    // var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
  

 //function for update or put
  Future<http.Response> editarAlumno(
    String id, 
    String nombreController,
    String apellidoController,
    String dniController,
    String codigoController,
    String correoController,
    String fotoController) async {
    int a = int.parse(id);
    print(a);


       Map data = {
      'id': '$a',
      'nombre': '$nombreController',
      'apellido': '$apellidoController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'correo': '$correoController',
      'foto': '$fotoController',
    };
    //encode Map to JSON
    var body = json.encode(data);

    // var response = await http.put(Uri.parse(url),
       var response = await http.put(Uri.parse(ConfigApi.buildUrl('/alumno')),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

Future<http.Response> removerAlumno(String id, String fotoURL) async {
  int a = int.parse(id);
  print(a);

  var url = ConfigApi.buildUrl('/alumno/$a');
  
  // Verifica si la fotoURL no es nula ni vacía antes de intentar eliminarla
  if (fotoURL != null && fotoURL.isNotEmpty) {
    // Elimina la foto de Firebase Storage
    await FirebaseStorage.instance.refFromURL(fotoURL).delete();
  }

  var response = await http.delete(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  print("${response.statusCode}");
  return response;
}
}
