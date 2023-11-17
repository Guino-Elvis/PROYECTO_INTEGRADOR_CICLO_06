// ignore_for_file: file_names
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:excel/excel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UsuarioController {

    Future<List<dynamic>> getData() async {
      final response =
          await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
      return json.decode(response.body);
    }

  Future<http.Response> CrearUsuario(
    String nameController,
    String roleController,
    String emailController,
    String passwordController,
    String confirmPasswordController,
    String apellido_pController,
    String apellido_mController,
    String dniController,
    String codigoController,
    String fotoController,

  ) async {
    Map data = {
      'name': '$nameController',
      'role': '$roleController',
      'email': '$emailController',
      'password': '$passwordController',
      'confirmPassword': '$confirmPasswordController',
      'apellido_p': '$apellido_pController',
      'apellido_m': '$apellido_mController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'foto': '$fotoController',

    };

    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(ConfigApi.buildUrl('/auth/create')),
            // var response = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  //function for update or put
  Future<http.Response> editarUsuario(
    String id,
    String nameController,
    String apellido_pController,
    String apellido_mController,
    String dniController,
    String codigoController,
    String roleController,
    String emailController,
    String passwordController,
     String fotoController,
  ) async {
    int a = int.parse(id);
    print(a);

    Map data = {
      'id': '$a',
      'name': '$nameController',
      'apellido_p': '$apellido_pController',
      'apellido_m': '$apellido_mController',
      'dni': '$dniController',
      'codigo': '$codigoController',
      'role': '$roleController',
      'email': '$emailController',
      'password': '$passwordController',
      'foto': '$fotoController',

    };

    // Codifica el Map en JSON
    var body = json.encode(data);

    var response = await http.put(
      Uri.parse(ConfigApi.buildUrl('/auth')),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  Future<http.Response> removerUsuario(String id, String fotoURL) async {
    int a = int.parse(id);
    print(a);

    var url = ConfigApi.buildUrl('/auth/delete/$a');

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

Future<void> exportDataToExcel() async {
  try {
    List<dynamic> data = await getData();
    final excel = Excel.createExcel();
    
    final sheet = excel['Sheet1'];
    sheet.appendRow(['id','codigo','role','email', 'apellido_p', 'apellido_m','name', 'dni' ,'created_at' ,'updated_at']); 
    for (var item in data) {
      // Obtener solo el año, mes y día de created_at y updated_at
      DateTime createdAt = DateTime.parse(item['created_at']);
      DateTime updatedAt = DateTime.parse(item['updated_at']);
      String createdAtFormatted = "${createdAt.year}-${createdAt.month}-${createdAt.day}";
      String updatedAtFormatted = "${updatedAt.year}-${updatedAt.month}-${updatedAt.day}";

      sheet.appendRow([item['id'], item['codigo'], item['role'], item['email'], item['apellido_p'], item['apellido_m'], item['name'], item['dni'], createdAtFormatted, updatedAtFormatted]); 
    }

    final dir = await AndroidPathProvider.downloadsPath;
    final excelFile = File('$dir/usuariodata.xlsx');

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
    List<dynamic> data = await getData();
    
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
                ['id', 'codigo', 'role', 'email', 'apellido_p', 'apellido_m', 'name', 'dni', 'created_at', 'updated_at'],
                for (var item in data)
                  [item['id'], item['codigo'], item['role'], item['email'], item['apellido_p'], item['apellido_m'], item['name'], item['dni'], item['created_at'], item['updated_at']],
              ]),
            ],
          );
        },
      ),
    );

    final dir = await AndroidPathProvider.downloadsPath;
    final pdfFile = File('$dir/usuariodata.pdf');

    await pdfFile.writeAsBytes(await pdf.save());
    print("PDF file saved in Downloads directory: ${pdfFile.path}");
  } catch (e) {
    print("Error during export: $e");
    throw e;
  }
}

}
