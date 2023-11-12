import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservaLibController {




  // Future<List<dynamic>> getDataReserva() async {
  //   final authResponse = await ShareApiTokenService.loginDetails();
  //   if (authResponse != null) {
  //     final token = authResponse.token;
  //     if (token != null && token.isNotEmpty) {
  //       final url = Uri.parse(ConfigApi.buildUrl('/reserva'));
  //       final response = await http.get(
  //         url,
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       );

  //       if (response.statusCode == 200) {
  //         List<dynamic> responseData = json.decode(response.body);
  //         for (var item in responseData) {
  //           if (item['created_at'] is String) {
  //             item['created_at'] = DateTime.parse(item['created_at']);
  //           }
  //           if (item['updated_at'] is String) {
  //             item['updated_at'] = DateTime.parse(item['updated_at']);
  //           }
  //         }
  //         return responseData;
  //       } else {
  //         print(
  //             "Error al obtener datos de reserva. Código de estado: ${response.statusCode}");
  //         return [];
  //       }
  //     }
  //   }
  //   return [];
  // }

Future<List<dynamic>> getDataReserva() async {
  // Obtén los detalles de autenticación del usuario
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
     // Obtiene el ID del usuario que ha iniciado sesión
    final userId = authResponse.user?.id;
    if (userId != null) {
      // Obtiene el token de autenticación del usuario
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        // Construye la URL para la solicitud de reservas
        final url = Uri.parse(ConfigApi.buildUrl('/reserva'));
         // Realiza la solicitud HTTP con el token de autenticación
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
            // Decodifica la respuesta JSON
          List<dynamic> responseData = json.decode(response.body);

          // Filtra las reservas por el ID del usuario logeado
          List<dynamic> userReservas = responseData.where((reserva) => reserva['userId'] == userId).toList();

          for (var item in userReservas) {
            if (item['created_at'] is String) {
              item['created_at'] = DateTime.parse(item['created_at']);
            }
            if (item['updated_at'] is String) {
              item['updated_at'] = DateTime.parse(item['updated_at']);
            }
          }
            // Devuelve las reservas filtradas por el ID del usuario logeado
          return userReservas;
        } else {
          print("Error al obtener datos de reserva. Código de estado: ${response.statusCode}");
          return [];
        }
      }
    }
  }

  return [];
}

  Future<http.Response> CrearReservaLib(
    String userIdController,
    Object libroController,
    String fecha_reservaController,
    String estado_reservaController,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        Map data = {
          'userId': '$userIdController',
          'libro': {
            'id': (libroController is Map)
                ? libroController['id']
                : libroController.toString(),
          },
          'fecha_reserva': '$fecha_reservaController',
          'estado_reserva': '$estado_reservaController',
        };

        var body = json.encode(data);

        // Imprime el cuerpo de la solicitud antes de enviarla
        print('Cuerpo de la solicitud: $body');

        var response = await http.post(
          Uri.parse(ConfigApi.buildUrl('/reserva')),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: body,
        );

        print("${response.statusCode}");
        print("${response.body}");
        return response;
      }
    }

    throw Exception('Token de autenticación no disponible');
  }

  Future<http.Response> editarReservaLib(
    String id,
    String userIdController,
    Object libroController,
    String fecha_reservaController,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        int a = int.parse(id);

        Map data = {
          'id': '$a',
          'userId': '$userIdController',
          'libro': {
            'id': (libroController is Map)
                ? libroController['id']
                : libroController.toString(),
          },
          'dni': '$fecha_reservaController',
        };

        var body = json.encode(data);

        var response = await http.put(
          Uri.parse(ConfigApi.buildUrl('/reserva')),
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

  Future<http.Response> removerReservaLib(
    String id,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        int a = int.parse(id);
        print(a);

        var url = ConfigApi.buildUrl('/reserva/$a');

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
