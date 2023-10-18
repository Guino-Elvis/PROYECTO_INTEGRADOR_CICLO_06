import 'dart:convert';

import 'package:flutter_application_1/src/config/configapi.dart';
import 'package:flutter_application_1/src/model/auth/AuthRequestModel.dart';
import 'package:flutter_application_1/src/model/auth/AuthResponseModel.dart';
import 'package:flutter_application_1/src/model/auth/RegisterRequestModel.dart';
import 'package:flutter_application_1/src/model/auth/RegisterResponseModel.dart';
import 'package:flutter_application_1/src/pages/auth/UserProfile.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  static var client = http.Client();

  // static Future<bool> login(AuthRequestModel model) async{
  //   Map<String, String> requestHeaders = {
  //     'Content-Type':'application/json',
  //   };

  //   var url = Uri.http(ConfigApi.apiURL, ConfigApi.loginAPI);

  //   var response = await client.post(
  //     url , 
  //     headers: requestHeaders,
  //     body: jsonEncode(model.toJson()),
  //   );
  //   if(response.statusCode == 200){
  //     await ShareApiTokenService.setLoginDetails(authResponseJson(response.body));
      
  //     return true;
  //   } else{
  //     return false;
  //   }
  // }

  static Future<bool> login(AuthRequestModel model) async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.loginAPI);

  var response = await client.post(
    url,
    headers: requestHeaders,
    body: jsonEncode(model.toJson()),
  );
  if (response.statusCode == 200) {
    final authResponse = authResponseJson(response.body);

    // Agrega esta línea para imprimir el token en la consola
    print('Token obtenido en el inicio de sesión: ${authResponse.token}');

    await ShareApiTokenService.setLoginDetails(authResponse);

    return true;
  } else {
    return false;
  }
}


static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.registerAPI);

  try {
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseModel(response.body);
  } catch (error) {
    // En caso de error, lanzar una excepción con el mensaje de error.
    throw Exception("Error en el registro: $error");
  }
}
  static Future<List<String>> getUserProfile() async {
  var loginDetails = await ShareApiTokenService.loginDetails();
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ${loginDetails!.token}',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.listUserAPI);

  var response = await client.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final List<String> emails = jsonData.map((dynamic item) {
      return item["email"].toString(); // Ajusta la extracción al campo "email"
    }).toList();

    return emails;
  } else {
    return [];
  }
}

static Future<List<Map<String, String>>> getUserProfilee() async {
  var loginDetails = await ShareApiTokenService.loginDetails();
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ${loginDetails!.token}',
  };

  var url = Uri.http(ConfigApi.apiURL, ConfigApi.listUserAPI);

  try {
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Map<String, String>> profiles = jsonData.map((dynamic item) {
        return {
          "name": item["name"].toString(),
          "email": item["email"].toString(),
          "foto": item["foto"].toString(),
        };
      }).toList();

      return profiles;
    } else {
      return [];
    }
  } catch (error) {
    // En caso de error, lanza una excepción con el mensaje de error.
    throw Exception("Error al obtener el perfil de usuario: $error");
  }
}



}