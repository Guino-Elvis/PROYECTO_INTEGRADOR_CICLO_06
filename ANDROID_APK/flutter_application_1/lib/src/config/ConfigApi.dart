import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';

class ConfigApi {
  static const String appName = "Colegio";
  static const String apiURL = "192.168.0.104:9090";
  static const String loginAPI = "/auth/login";
  static const String registerAPI = "/auth/create";
  static const String listUserAPI = "/auth/list";


  
//   static String buildUrl(String endpoint) {
//     return '$apiURL';
//   }


  static String buildUrl(String endpoint) {
    return 'http://$apiURL$endpoint';
  }

  static String buildUrltoken(String endpoint) {
    return 'http://$apiURL$endpoint';
  }



//   static String buildUrl(String endpoint, {String? token}) {
//   var baseUrl = 'http://$apiURL$endpoint';
//   if (token != null) {
//     baseUrl += '?token=$token';
//   }
//   return baseUrl;
// }
}

