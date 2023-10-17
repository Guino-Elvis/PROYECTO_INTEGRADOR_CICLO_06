import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
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

    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
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
        
        var response = await http.post(
          Uri.parse(ConfigApi.buildUrl('/alumno')),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token', // Agregar el token de autenticación en el encabezado
          },
          body: body,
        );
        
        print("${response.statusCode}");
        print("${response.body}");
        return response;
      }
    }
    
    // Manejar el caso en el que no se pudo obtener el token de autenticación lanzando una excepción.
    throw Exception('Token de autenticación no disponible');
  }


  Future<http.Response> editarAlumno(
  String id, 
  String nombreController,
  String apellidoController,
  String dniController,
  String codigoController,
  String correoController,
  String fotoController) async {
  
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
    final token = authResponse.token;
    if (token != null && token.isNotEmpty) {
      int a = int.parse(id);

      Map data = {
        'id': '$a',
        'nombre': '$nombreController',
        'apellido': '$apellidoController',
        'dni': '$dniController',
        'codigo': '$codigoController',
        'correo': '$correoController',
        'foto': '$fotoController',
      };
      
      var body = json.encode(data);

      var response = await http.put(
        Uri.parse(ConfigApi.buildUrl('/alumno')),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token', // Agregar el token de autenticación en el encabezado
        },
        body: body,
      );
      
      print("${response.statusCode}");
      print("${response.body}");
      return response;
    }
  }

  // Manejar el caso en el que no se pudo obtener el token de autenticación lanzando una excepción.
  throw Exception('Token de autenticación no disponible');
}


Future<http.Response> removerAlumno(String id, String fotoURL) async {
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
    final token = authResponse.token;
    if (token != null && token.isNotEmpty) {
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
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token', // Agregar el token de autenticación en el encabezado
        },
      );
      print("${response.statusCode}");
      return response;
    }
  }

  // Manejar el caso en el que no se pudo obtener el token de autenticación lanzando una excepción.
  throw Exception('Token de autenticación no disponible');
}
}
