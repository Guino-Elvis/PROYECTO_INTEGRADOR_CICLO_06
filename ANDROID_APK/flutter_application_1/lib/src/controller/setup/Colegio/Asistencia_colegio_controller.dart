import 'dart:convert';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;

class AsistenciaController {

Future<List<Map<String, dynamic>>> getAsistencias() async {
  try {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final userId = authResponse.user?.id;
      final token = authResponse.token;
      if (userId != null && token != null && token.isNotEmpty) {
        final url = Uri.parse(ConfigApi.buildUrl('/asistencia'));
        final response = await http.get(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final asistencias = List<Map<String, dynamic>>.from(json.decode(response.body));

          final asistenciaPromises = asistencias.map((asistencia) async {
            final detalle = asistencia['detalle'];
            final detalleItems = await _fetchDetalleItems(token, detalle, userId);

            final cursoId = asistencia['cursoId'];
            final cursoInfo = await _fetchCursoInfo(token, cursoId);

            final cursoNombre = cursoInfo['nombre']; // Asegúrate de que 'nombre' sea el campo correcto en tu API.

            final filteredDetalleItems = detalleItems.where((item) => item.isNotEmpty).toList();

            return {
              ...asistencia,
              'detalle': filteredDetalleItems,
              'cursoInfo': cursoInfo,
              'cursoNombre': cursoNombre,
            };
          }).toList();

          final asistenciasConDetalles = await Future.wait(asistenciaPromises);

          return asistenciasConDetalles;
        } else {
          print('Error en la solicitud HTTP de asistencias: ${response.statusCode}');
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }

  return [];
}

Future<Map<String, dynamic>> _fetchCursoInfo(String token, int cursoId) async {
  try {
    final url = Uri.parse(ConfigApi.buildUrl('/curso/$cursoId')); // Asegúrate de tener la ruta correcta para obtener información del curso
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error en la solicitud HTTP de información del curso: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al obtener información del curso: $e');
  }

  return {};
}


 Future<List<Map<String, dynamic>>> _fetchDetalleItems(String token, List<dynamic> detalle, int userId) async {
  List<Future<Map<String, dynamic>>> detallePromises = detalle.map<Future<Map<String, dynamic>>>((detalleItem) async {
    final itemUserId = detalleItem['userId'];

    if (itemUserId == userId) {
      // Obtener información del usuario si el ID del usuario coincide con el ID del usuario logeado
      final userResponse = await http.get(
        Uri.parse(ConfigApi.buildUrl('/auth/$itemUserId')),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (userResponse.statusCode == 200) {
        final userResponseBody = json.decode(userResponse.body);
        // Incluir información del usuario y del detalleItem original
        return {
          'user': userResponseBody,
          'id': detalleItem['id'],
          'status': detalleItem['status'],
          'created_at': detalleItem['created_at'],
          'updated_at': detalleItem['updated_at'],
        };
      } else {
        return {}; // Tratar errores si es necesario
      }
    } else {
      return {}; // No coinciden los IDs, no incluir este detalleItem
    }
  }).toList();

  // Esperar a que todas las solicitudes de detalle se completen
  return await Future.wait(detallePromises);
}


}
