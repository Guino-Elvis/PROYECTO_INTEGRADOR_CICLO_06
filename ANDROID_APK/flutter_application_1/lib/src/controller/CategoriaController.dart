import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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

// Future<http.Response> editarCategoria(
//     String id, 
//     String tituloController,
//     String descripccionController, 
//     String fotoController) async {
//   int a = int.parse(id);
//   print("ID: $a");

//   var url = 'http://192.168.0.104:9090/categoriablog';
  
//   // Comprueba si la imagen se ha modificado
//   var widget;
//   bool imagenCambiada = (fotoController != widget.list[widget.index]['foto']);
//   print("Imagen cambiada: $imagenCambiada");

//   if (imagenCambiada) {
//     // Elimina la imagen anterior en Firebase Storage
//     await FirebaseStorage.instance.refFromURL(widget.list[widget.index]['foto']).delete();
//     // Sube la nueva imagen a Firebase Storage
//     final firebaseStorageReference = FirebaseStorage.instance.ref().child('categoriablog/$a.png');
//     await firebaseStorageReference.putFile(File(fotoController));
//   }

//   Map data = {
//     'id': '$a',
//     'titulo': '$tituloController',
//     'descripccion': '$descripccionController',
//     'foto': imagenCambiada ? 'URL_DE_LA_IMAGEN_NUEVA' : widget.list[widget.index]['foto'],
//   };
//   //encode Map to JSON
//   var body = json.encode(data);

//   var response = await http.put(Uri.parse('$url/$a'), // Asegúrate de incluir el ID en la URL de la solicitud
//       headers: {"Content-Type": "application/json"}, body: body);
//   print("Response status code: ${response.statusCode}");
//   print("Response body: ${response.body}");
//   return response;
// }

 //Funcion para eliminar un producto a la BD
 Future<http.Response> removerCategoria(String id, String fotoURL) async {
  int a = int.parse(id);
  print(a);
  var url = 'http://192.168.0.104:9090/categoriablog/$a';

  // Elimina la foto de Firebase Storage
  await FirebaseStorage.instance.refFromURL(fotoURL).delete();

  var response = await http.delete(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  print("${response.statusCode}");
  return response;
}

  // Future<http.Response> removerCategoria(String id) async {
  //   int a = int.parse(id);
  //   print(a);
  //   var url = 'http://192.168.0.104:9090/categoriablog/$a';

  //   var response =
  //       await http.delete(Uri.parse(url),
  //        headers: {"Content-Type": "application/json"});
  //   print("${response.statusCode}");
  //   return response;
  // }
}
