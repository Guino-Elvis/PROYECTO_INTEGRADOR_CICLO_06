import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/model/auth/AuthResponseModel.dart';
// import 'package:flutter_application_1/src/sql/ApiCacheDatabase.dart';
import 'package:http/http.dart' as http;
class ShareApiTokenService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login_details");
    return isKeyExist;
  }

  static Future<AuthResponseModel?> loginDetails () async {
    
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login_details");
    
    if(isKeyExist){
      var cacheData = await APICacheManager().getCacheData("login_details");

      return authResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(
    AuthResponseModel model,
  )async{
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: "login_details",
       syncData: jsonEncode(model.toJson()),
      );

      await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async{
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context, 
      '/login', 
      (route) => false
      );
  }


//  static Future<bool> isAdmin() async {
//     try {
//       final response = await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data is List) {
//           // Suponiendo que la respuesta es una lista y contiene al menos un elemento
//           final firstUser = data[0];
//           // Suponiendo que el campo "role" indica el rol del usuario
//           final userRole = firstUser['role'] as String;
//           // Verificar si el usuario es un administrador
//           return userRole == 'admin';
//         }
//         return false; // Si no se encontraron usuarios
//       } else {
//         // Manejar errores, por ejemplo, lanzar una excepción
//         throw Exception('No se pudo obtener el estado de administrador');
//       }
//     } catch (e) {
//       // Manejar errores, por ejemplo, lanzar una excepción
//       throw Exception('Error en la solicitud HTTP: $e');
//     }
//   }


Future<bool> hasRole(String role) async {
  try {
    final response = await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        final firstUser = data[0];
        final userRole = firstUser['role'] as String;
        return userRole == role;
      }
      return false;
    } else {
      throw Exception('No se pudo obtener el estado de $role');
    }
  } catch (e) {
    throw Exception('Error en la solicitud HTTP: $e');
  }
}

}


// class ShareApiTokenService {
//   static Future<bool> isLoggedIn() async {
//     final apiCacheDatabase = ApiCacheDatabase();
//     await apiCacheDatabase.open();
    
//     final isKeyExist = await apiCacheDatabase.getCache("login_details");
    
//     return isKeyExist != null;
//   }

//   static Future<AuthResponseModel?> loginDetails () async {
//     final apiCacheDatabase = ApiCacheDatabase();
//     await apiCacheDatabase.open();
    
//     final cacheData = await apiCacheDatabase.getCache("login_details");
    
//     if (cacheData != null) {
//       return authResponseJson(cacheData);
//     }

//     return null;
//   }

//   static Future<void> setLoginDetails(AuthResponseModel model) async {
//     final apiCacheDatabase = ApiCacheDatabase();
//     await apiCacheDatabase.open();

//     final cacheData = jsonEncode(model.toJson());
//     await apiCacheDatabase.insertOrUpdateCache("login_details", cacheData);
//   }

//   static Future<void> logout(BuildContext context) async {
//     final apiCacheDatabase = ApiCacheDatabase();
//     await apiCacheDatabase.open();

//     await apiCacheDatabase.insertOrUpdateCache("login_details", '');
    
//     Navigator.pushNamedAndRemoveUntil(
//       context, 
//       '/login', 
//       (route) => false,
//     );
//   }

