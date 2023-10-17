class ConfigApi {
  static const String appName = "Colegio";
  static const String apiURL = "192.168.0.104:9090";
  static const String loginAPI = "/auth/login";
  static const String registerAPI = "/auth/create";
  static const String listUserAPI = "/auth/list";

  static String buildUrl(String endpoint) {
    return 'http://$apiURL$endpoint';
  }

}

