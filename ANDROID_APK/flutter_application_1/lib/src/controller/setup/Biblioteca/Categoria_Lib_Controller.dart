import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/model/setup/Categoria_Lib_Model.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';

import 'package:pdf/pdf.dart';

class CategorialibControllerLib {
  Future<Map<String, dynamic>> getCategoriaPorId(int categoriaId) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse(ConfigApi.buildUrl('/categorialib/$categoriaId'));
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        return json.decode(response.body);
      }
    }

    return {}; // Otra acción que consideres apropiada si el token no está disponible.
  }

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
    required int categoriaId,
    String formato = '',
  }) async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        final url = categoriaId != null
            ? Uri.parse(
                ConfigApi.buildUrl('/libro/libroPorCategoria/$categoriaId'))
            : Uri.parse(ConfigApi.buildUrl('/libro'));

        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> libros = json.decode(response.body);

          // Filtrar libros por formato si se proporciona el parámetro
          if (formato != null && formato.isNotEmpty) {
            return libros
                .where((libro) => libro['formato'] == formato)
                .toList();
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

  //add categoria - CRUD
  Future<http.Response> CrearCategoria(CategoriaLibModel nuevaCategoria) async {
  final authResponse = await ShareApiTokenService.loginDetails();

  if (authResponse != null) {
    final token = authResponse.token;

    if (token != null && token.isNotEmpty) {
      final body = json.encode(nuevaCategoria.toJson());

      final response = await http.post(
        Uri.parse(ConfigApi.buildUrl('/categorialib')),
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

  // Manejar el caso en el que no se pudo obtener el token de autenticación lanzando una excepción.
  throw Exception('Token de autenticación no disponible');
}


  //function for update or put
Future<http.Response> editarCategoria(CategoriaLibModel categoria) async {
  final authResponse = await ShareApiTokenService.loginDetails();

  if (authResponse != null) {
    final token = authResponse.token;

    if (token != null && token.isNotEmpty) {
      var body = json.encode(categoria.toJson());

      var response = await http.put(
        Uri.parse(ConfigApi.buildUrl('/categorialib')),
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

  // Manejar el caso en el que no se pudo obtener el token de autenticación lanzando una excepción.
  throw Exception('Token de autenticación no disponible');
}


Future<http.Response> removerCategoria(String id, String fotoURL) async {
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
      var url = ConfigApi.buildUrl('/categorialib/$a');
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
      List<dynamic> data = await getDataCategorialib();
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
      List<dynamic> data = await getDataCategorialib();

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
