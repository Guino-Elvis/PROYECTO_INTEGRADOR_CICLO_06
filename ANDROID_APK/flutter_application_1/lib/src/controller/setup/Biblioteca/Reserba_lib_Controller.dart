import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class ReservaLibController {
  Future<List<dynamic>> getDataListReserva() async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse(ConfigApi.buildUrl('/reserva'));
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        return json.decode(response.body);
      }
    }

    return [];
  }

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
            List<dynamic> userReservas = responseData
                .where((reserva) => reserva['userId'] == userId)
                .toList();

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
            print(
                "Error al obtener datos de reserva. Código de estado: ${response.statusCode}");
            return [];
          }
        }
      }
    }

    return [];
  }

  Future<http.Response> crearReservaLib(
    String userIdController,
    dynamic libroId,
    String fecha_reservaController,
    String estado_reservaController,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        Map data = {
          'userId': '$userIdController',
          'libro': libroId,
          'fecha_reserva': '$fecha_reservaController',
          'estado_reserva': '$estado_reservaController',
        };
        var body = json.encode(data);
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
    dynamic libroController,
    String fecha_reservaController,
    String estado_reservaController,
  ) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        int a = int.parse(id);
        // Convierte la categoría a un formato esperado por el backend
        Map<String, dynamic> libroData = {
          'id': libroController['id'],
        };
        Map data = {
          'id': '$a',
          'userId': '$userIdController',
          'libro': libroData, // Usa la categoría convertida
          'fecha_reserva': '$fecha_reservaController',
          'estado_reserva': '$estado_reservaController',
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

  Future<void> exportDataToExcel() async {
    try {
      List<dynamic> data = await getDataListReserva();
      final excel = Excel.createExcel();

      final sheet = excel['Sheet1'];
      sheet.appendRow([
        'id',
        'usuario',
        'libro',
        'fechareserba',
        'estadreserva',
        'created_at',
        'updated_at'
      ]);
      for (var item in data) {
        // Obtener solo el año, mes y día de created_at y updated_at
        DateTime createdAt = DateTime.parse(item['created_at']);
        DateTime updatedAt = DateTime.parse(item['updated_at']);
        String createdAtFormatted =
            "${createdAt.year}-${createdAt.month}-${createdAt.day}";
        String updatedAtFormatted =
            "${updatedAt.year}-${updatedAt.month}-${updatedAt.day}";

        sheet.appendRow([
          item['id'],
          item['userId'],
          item['libro'],
          item['fecha_reserva'],
          item['estado_reserva'],
          createdAtFormatted,
          updatedAtFormatted
        ]);
      }

      final dir = await AndroidPathProvider.downloadsPath;
      final excelFile = File('$dir/reservadata.xlsx');

      final excelData = excel.encode();
      if (excelData != null) {
        await excelFile.writeAsBytes(excelData);
        print("Excel file saved in Downloads directory: ${excelFile.path}");
      } else {
        print("Excel data is null");
      }
    } catch (e) {
      print("Error during export: $e");
      throw e;
    }
  }

  Future<void> exportDataToPDF() async {
    try {
      List<dynamic> data = await getDataListReserva();

      final pdf = pw.Document();

      // Establecer el tamaño de la página en orientación horizontal
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.copyWith(
            width: PdfPageFormat.a4.height,
            height: PdfPageFormat.a4.width,
          ),
          build: (context) {
            return pw.Column(
              children: [
                pw.Table.fromTextArray(context: context, data: [
                  ['id', 'titulo', 'descripcion', 'created_at', 'updated_at'],
                  for (var item in data)
                    [
                      item['id'],
                      item['userId'],
                      item['libro'],
                      item['fecha_reserva'],
                      item['estado_reserva'],
                      item['created_at'],
                      item['updated_at']
                    ],
                ]),
              ],
            );
          },
        ),
      );

      final dir = await AndroidPathProvider.downloadsPath;
      final pdfFile = File('$dir/reservadata.pdf');

      await pdfFile.writeAsBytes(await pdf.save());
      print("PDF file saved in Downloads directory: ${pdfFile.path}");
    } catch (e) {
      print("Error during export: $e");
      throw e;
    }
  }
}
