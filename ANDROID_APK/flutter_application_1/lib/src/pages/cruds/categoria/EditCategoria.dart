import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_application_1/src/pages/cruds/categoria/CategoriaList.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';


class EditCategoria extends StatefulWidget {
  final List list;
  final int index;

  const EditCategoria({required this.list, required this.index});

  @override
  State<EditCategoria> createState() => _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  CategorialibControllerLib categorialibControllerLib = CategorialibControllerLib();

  late TextEditingController controllerid;
  late TextEditingController controllertitulo;
  late TextEditingController controllerdescripcion;
  late TextEditingController controllerfoto;
  File? selectedImage;
  String categoriaImageURL = "";

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriaList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllertitulo = TextEditingController(
        text: widget.list[widget.index]['titulo']?.toString() ??
            'titulo no especificado');
    controllerdescripcion = TextEditingController(
        text: widget.list[widget.index]['descripcion']?.toString() ??
            'descripcion no especificado');
    categoriaImageURL = widget.list[widget.index]['foto'] != null
        ? widget.list[widget.index]['foto'].toString()
        : 'assets/nofoto.jpg';

    selectedImage = File(categoriaImageURL);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
    }
  }

  // Future<void> _updateImageInFirebase() async {
  //   String newImageUrl =
  //       widget.list[widget.index]['foto'] ?? ""; // Default to an empty string
  //   if (selectedImage != null) {
  //     final firebaseStorageReference =
  //         FirebaseStorage.instance.ref().child('categoriablog/${DateTime.now()}.png');

  //     try {
  //       await firebaseStorageReference.putFile(selectedImage!);
  //       final downloadUrl = await firebaseStorageReference.getDownloadURL();

  //       if (downloadUrl != null) {
  //         newImageUrl =
  //             downloadUrl;
  //       } else {
         
  //       }
  //     } catch (e) {
  //       print("Error al cargar la imagen: $e");
  //     }
  //   }

  //   // Actualiza la categoría, incluyendo la URL de la imagen (ya sea la existente o la nueva)
  //   categorialibControllerLib.editarCategoria(
  //     controllerid.text.trim(),
  //     controllertitulo.text.trim(),
  //     controllerdescripcion.text.trim(),
  //     newImageUrl,
  //   );

  //   _navigateList(context);
  // }

String calculateMD5(File file) {
  final content = file.readAsBytesSync();
  final digest = md5.convert(content);
  return digest.toString();
}

// Future<void> _updateImageInFirebase() async {
//   String newImageUrl = widget.list[widget.index]['foto'] ?? "";

//   if (selectedImage != null) {
//     final firebaseStorageReference = FirebaseStorage.instance
//         .ref()
//         .child('categoriablog/${calculateMD5(selectedImage!)}.png');

//     try {
//       await firebaseStorageReference.putFile(selectedImage!);
//       final downloadUrl = await firebaseStorageReference.getDownloadURL();

//       if (downloadUrl != null) {
//         newImageUrl = downloadUrl;
//       } else {
//         // Handle the case where the download URL is null
//       }
//     } catch (e) {
//       print("Error al cargar la imagen: $e");
//     }
//   }

//   categorialibControllerLib.editarCategoria(
//     controllerid.text.trim(),
//     controllertitulo.text.trim(),
//     controllerdescripcion.text.trim(),
//     newImageUrl,
//   );

//   _navigateList(context);
// }


Future<void> _updateImageInFirebase() async {
  String newImageUrl = widget.list[widget.index]['foto'] ?? "";
  String categoryId = controllerid.text.trim();
  String categoryTitle = controllertitulo.text.trim();

  if (selectedImage != null) {
    // Concatena el ID y el título de la categoría en el nombre del archivo
    String fileName = 'categoriablog/$categoryId-$categoryTitle.png';

    final firebaseStorageReference =
        FirebaseStorage.instance.ref().child(fileName);

    try {
      await firebaseStorageReference.putFile(selectedImage!);
      final downloadUrl = await firebaseStorageReference.getDownloadURL();

      if (downloadUrl != null) {
        newImageUrl = downloadUrl;
      } else {
        // Manejar el caso donde la URL de descarga es nula
      }
    } catch (e) {
      print("Error al cargar la imagen: $e");
    }
  }

  categorialibControllerLib.editarCategoria(
    categoryId,
    categoryTitle,
    controllerdescripcion.text.trim(),
    newImageUrl,
  );

  _navigateList(context);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Categoria"),
      ),
      body: SlideInUp(
        child: Form(
          child: BounceInRight(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      child: ListTile(
                        leading: Icon(Icons.title, color: Colors.black),
                        title: TextFormField(
                          controller: controllerid,
                          decoration: InputDecoration(
                            hintText: "id",
                            labelText: "id",
                          ),
                        ),
                      ),
                    ),
                    Card(
                        elevation: 4, // Define la elevación de la sombra negra
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Define la forma del Card
                        ),
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0), // Hace que la imagen esté recortada con bordes redondeados
                            child: CachedNetworkImage(
                              imageUrl: categoriaImageURL.isNotEmpty
                                  ? categoriaImageURL
                                  : 'assets/nofoto.jpg',
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/nofoto.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllertitulo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "titulo",
                          labelText: "titulo de la categoria",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: TextFormField(
                        controller: controllerdescripcion,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Descripcion",
                          labelText: "Descripcion de la categoria",
                        ),
                      ),
                    ),
                   
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Container(child: Text("Cambiar Foto")),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            _updateImageInFirebase();
                          },
                          child: Container(child: Text("Editar")),
                        ),
                        SizedBox(width: 16), // Agrega un espacio entre los botones
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/category');
                          },
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
