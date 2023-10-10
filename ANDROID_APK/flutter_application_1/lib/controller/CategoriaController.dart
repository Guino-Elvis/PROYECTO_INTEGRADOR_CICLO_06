import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriaController {
  //add categoria - CRUD
  Future<http.Response> CrearCategoria(
    String tituloController,
    String descripccionController,
    String fotoController,
    // String created_atController,
    // String updated_atController,
  ) async {
    var url = 'http://192.168.0.104:9090/categoriablog';
    Map data = {
      'titulo': '$tituloController',
      'descripccion': '$descripccionController',
      'foto': '$fotoController',
      // 'created_at': '$created_atController',
      // 'updated_at': '$updated_atController',
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }


 //function for update or put
  Future<http.Response> editarCategoria(
    String id, 
    String tituloController,
    String descripccionController, 
    String fotoController) async {
    int a = int.parse(id);
    print(a);
    var url = 'http://192.168.0.104:9090/categoriablog';

    Map data = {
      'id': '$a',
      'titulo': '$tituloController',
      'descripccion': '$descripccionController',
      'foto': '$fotoController',
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.put(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }


 //Funcion para agregar un producto a la BD
  Future<http.Response> removerCategoria(String id) async {
    int a = int.parse(id);
    print(a);
    var url = 'http://192.168.0.104:9090/categoriablog/$a';

    var response =
        await http.delete(Uri.parse(url),
         headers: {"Content-Type": "application/json"});
    print("${response.statusCode}");
    return response;
  }
}
