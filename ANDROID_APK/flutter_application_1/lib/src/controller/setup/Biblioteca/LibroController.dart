import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
class LibroController {

Future<List<dynamic>> getDataLibro({String formato = ''}) async {
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



  Future<http.Response> CrearLibro(
    String tituloController,
    String autorController,
    String isbnController,
    String descripcionController,
    String disponibilidadController,
    String formatoController,
    String estadoController,
    String fotoController,
    dynamic categoria,
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
          'categorialib': categoria, // Usa directamente el parámetro categoria
        };

        var body = json.encode(data);

        var response = await http.post(
          Uri.parse(ConfigApi.buildUrl('/libro')),
          headers: {
            "Content-Type": "application/json",
            'Authorization':
                'Bearer $token', // Agregar el token de autenticación en el encabezado
          },
          body: body,
        );
        // print("Selected Category: $categorialibController");
        print("${response.statusCode}");
        print("${response.body}");
   
        return response;
      }
    }
    throw Exception('Token de autenticación no disponible');
  }


 Future<http.Response> editarLibro(
  String id,
  String tituloController,
  String autorController,
  String isbnController,
  String descripcionController,
  String disponibilidadController,
  String formatoController,
  String estadoController,
  dynamic categoriaController,
  String fotoController,
) async {
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
    final token = authResponse.token;
    if (token != null && token.isNotEmpty) {
      int a = int.parse(id);

      // Convierte la categoría a un formato esperado por el backend
      Map<String, dynamic> categoriaData = {
        'id': categoriaController['id'],
        // Puedes agregar más propiedades según sea necesario
      };

      Map data = {
        'id': '$a',
        'titulo': '$tituloController',
        'autor': '$autorController',
        'isbn': '$isbnController',
        'descripcion': '$descripcionController',
        'disponibilidad': '$disponibilidadController',
        'formato': '$formatoController',
        'estado': '$estadoController',
        'categorialib': categoriaData, // Usa la categoría convertida
        'foto': '$fotoController',
      };

      var body = json.encode(data);

      var response = await http.put(
        Uri.parse(ConfigApi.buildUrl('/libro')),
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




  Future<http.Response> removerLibro(String id, String fotoURL) async {
  final authResponse = await ShareApiTokenService.loginDetails();
  if (authResponse != null) {
    final token = authResponse.token;
    if (token != null && token.isNotEmpty) {
      int a = int.parse(id);
      print(a);

      // Verifica si la fotoURL es una URL válida de Firebase Storage
      if (fotoURL != null && (fotoURL.startsWith('gs://') || fotoURL.startsWith('https://'))) {
        // Elimina la foto de Firebase Storage
        await FirebaseStorage.instance.refFromURL(fotoURL).delete();
      }

      // Elimina la categoría
      var url = ConfigApi.buildUrl('/libro/$a');
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
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
      List<dynamic> data = await getDataLibro();
      final excel = Excel.createExcel();

      final sheet = excel['Sheet1'];
      sheet.appendRow(
          ['id', 'titulo', 'descripcion', 'created_at', 'updated_at']);
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
          item['titulo'],
          item['descripcion'],
          createdAtFormatted,
          updatedAtFormatted
        ]);
      }

      final dir = await AndroidPathProvider.downloadsPath;
      final excelFile = File('$dir/cateogoriadata.xlsx');

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
      List<dynamic> data = await getDataLibro();

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
                      item['titulo'],
                      item['descripcion'],
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
      final pdfFile = File('$dir/cateogoriadata.pdf');

      await pdfFile.writeAsBytes(await pdf.save());
      print("PDF file saved in Downloads directory: ${pdfFile.path}");
    } catch (e) {
      print("Error during export: $e");
      throw e;
    }
  }
}
