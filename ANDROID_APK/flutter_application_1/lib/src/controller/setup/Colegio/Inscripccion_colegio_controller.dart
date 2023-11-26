import 'dart:convert';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;

class IncripcionController {


  Future<List<Map<String, dynamic>>> getInscripccions() async {
  try {
    // Obtén los detalles de autenticación del usuario
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      // Obtiene el ID del usuario que ha iniciado sesión
      final userId = authResponse.user?.id;
      if (userId != null) {
        // Obtiene el token de autenticación del usuario
        final token = authResponse.token;
        if (token != null && token.isNotEmpty) {
          // Construye la URL para la solicitud de inscripciones
          final url = Uri.parse(ConfigApi.buildUrl('/inscripccion'));
          // Realiza la solicitud HTTP con el token de autenticación
          final response = await http.get(
            url,
            headers: {'Authorization': 'Bearer $token'},
          );

          if (response.statusCode == 200) {
            // Decodifica la respuesta JSON
            final inscripccions = List<Map<String, dynamic>>.from(json.decode(response.body));

            // Filtra las inscripciones por el ID del usuario logeado
            final userInscripccions = inscripccions
                .where((inscripcion) => inscripcion['userId'] == userId)
                .toList();

            // Procesa los detalles de las inscripciones
            final inscripcionPromises = userInscripccions.map((inscripcion) async {
              final detalle = inscripcion['detalle'];
              final detalleItems = await _fetchDetalleItems(token, detalle);

              // Agregar la información del curso y docente al mapa de inscripción
              return {
                ...inscripcion,
                'detalle': detalleItems,
              };
            }).toList();

            // Espera a que todas las solicitudes de detalle se completen
            final inscripcionesConDetalles = await Future.wait(inscripcionPromises);

            return inscripcionesConDetalles;
          } else {
            // Manejar errores de estado HTTP para la obtención de inscripciones
            print('Error en la solicitud HTTP de inscripciones: ${response.statusCode}');
          }
        }
      }
    }
  } catch (e) {
    // Manejar otros errores
    print('Error: $e');
  }

  return [];
}


  Future<List<Map<String, dynamic>>> _fetchDetalleItems(String token, List<dynamic> detalle) async {
    List<Future<Map<String, dynamic>>> detallePromises = detalle.map<Future<Map<String, dynamic>>>((detalleItem) async {
      final cursoId = detalleItem['cursoId'];

      // Obtener información del curso
      final cursoResponse = await http.get(
        Uri.parse(ConfigApi.buildUrl('/curso/$cursoId')),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (cursoResponse.statusCode == 200) {
        final cursoResponseBody = json.decode(cursoResponse.body);
        
        // Obtener información del docente asociado al curso
        final docenteId = cursoResponseBody['docenteId'];
        final docenteResponse = await http.get(
          Uri.parse(ConfigApi.buildUrl('/docente/$docenteId')),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (docenteResponse.statusCode == 200) {
          final docenteResponseBody = json.decode(docenteResponse.body);
          return {
            'curso': cursoResponseBody,
            'docente': docenteResponseBody,
          };
        } else {
          return {}; // Tratar errores si es necesario
        }
      } else {
        return {}; // Tratar errores si es necesario
      }
    }).toList();

    // Esperar a que todas las solicitudes de detalle se completen
    return await Future.wait(detallePromises);
  }
}