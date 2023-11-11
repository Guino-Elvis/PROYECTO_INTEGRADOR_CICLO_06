import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategorialibControllerLib {
  
  Future<List<dynamic>> getDataCategorialib() async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse(ConfigApi.buildUrl('/categorialib'));
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        return json.decode(response.body);
      }
    }

    return []; // Otra acción que consideres apropiada si el token no está disponible.
  }

Future<List<dynamic>> getDataLibroPorIdCategoria({
  
  String formato = ''}) async {
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
    final token = authResponse.token;
    if (token != null && token.isNotEmpty) {
      final url = Uri.parse(ConfigApi.buildUrl('/libro'));
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> libros = json.decode(response.body);

        // Filtrar libros por formato si se proporciona el parámetro
        if (formato != null) {
          return libros.where((libro) => libro['formato'] == formato).toList();
        }

        return libros;
      } else {
        // Manejar el error de la solicitud HTTP, si es necesario
        print('Error en la solicitud HTTP: ${response.statusCode}');
        throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
      }
    }
  }

  return []; // Otra acción que consideres apropiada si el token no está disponible.
}



  Future<http.Response> CrearCategorialib(
    String tituloController,
    String autorController,
    String isbnController,
    String descripcionController,
    String disponibilidadController,
    String formatoController,
    String estadoController,
    String fotoController,
    String categoriaIdController,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        Map data = {
          'titulo': '$tituloController',
          'autor': '$autorController',
          'isbn': '$isbnController',
          'descripcion': '$descripcionController',
          'disponibilidad': '$disponibilidadController',
          'formato': '$formatoController',
          'estado': '$estadoController',
          'foto': '$fotoController',
          'categorialib': '$categoriaIdController',
        };

        var body = json.encode(data);

        var response = await http.post(
          Uri.parse(ConfigApi.buildUrl('/Categorialib')),
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer $token', // Agregar el token de autenticación en el encabezado
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

  Future<http.Response> editarCategorialib(
      String id,
      String tituloController,
      String autorController,
      String isbnController,
      String descripcionController,
      String disponibilidadController,
      String formatoController,
      String estadoController,
      String categoriaIdController,
      String fotoController) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        int a = int.parse(id);

        Map data = {
          'id': '$a',
          'titulo': '$tituloController',
          'autor': '$autorController',
          'isbn': '$isbnController',
          'descripcion': '$descripcionController',
          'disponibilidad': '$disponibilidadController',
          'formato': '$formatoController',
          'estado': '$estadoController',
          'categorialib': '$categoriaIdController',
          'foto': '$fotoController',
        };

        var body = json.encode(data);

        var response = await http.put(
          Uri.parse(ConfigApi.buildUrl('/Categorialib')),
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer $token', // Agregar el token de autenticación en el encabezado
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

  Future<http.Response> removerCategorialib(String id, String fotoURL) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        int a = int.parse(id);
        print(a);

        var url = ConfigApi.buildUrl('/Categorialib/$a');

        // Verifica si la fotoURL no es nula ni vacía antes de intentar eliminarla
        if (fotoURL != null && fotoURL.isNotEmpty) {
          // Elimina la foto de Firebase Storage
          await FirebaseStorage.instance.refFromURL(fotoURL).delete();
        }

        var response = await http.delete(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer $token', // Agregar el token de autenticación en el encabezado
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
