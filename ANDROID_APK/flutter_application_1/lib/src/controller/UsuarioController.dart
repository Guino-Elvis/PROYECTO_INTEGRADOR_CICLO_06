import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioController {

  Future<http.Response> CrearUsuario(
    String nameController,
    String roleController,
    String emailController,
    String passwordController,
    String confirmPasswordController,
    String fotoController,
    // String created_atController,
    // String updated_atController,
  ) async {


    Map data = {
      'name': '$nameController',
      'role': '$roleController',
      'email': '$emailController',
      'password': '$passwordController',
      'confirmPassword': '$confirmPasswordController',
      'foto': '$fotoController',
      // 'created_at': '$created_atController',
      // 'updated_at': '$updated_atController',
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(ConfigApi.buildUrl('/auth/create')),
    // var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
  

 //function for update or put
  Future<http.Response> editarUsuario(
  int id, // Debes recibir un entero (ID) como argumento
  String nameController,
  String roleController,
  String emailController, 
  String passwordController, 
  String fotoController,
) async {
  var url = ConfigApi.buildUrl('/auth/update/$id'); // Utiliza el ID proporcionado

  Map data = {
    'id': id, // Utiliza el ID proporcionado
    'name': nameController,
    'role': roleController,
    'email': emailController,
    'password': passwordController,
    'foto': fotoController,
  };
  
  // Codifica el Map en JSON
  var body = json.encode(data);

  var response = await http.put(
    Uri.parse(url),
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
}
