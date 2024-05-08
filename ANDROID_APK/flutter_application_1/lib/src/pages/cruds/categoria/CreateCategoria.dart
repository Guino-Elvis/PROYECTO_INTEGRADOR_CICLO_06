import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:flutter_application_1/src/model/setup/Categoria_Lib_Model.dart';
import 'package:flutter_application_1/src/pages/cruds/categoria/CategoriaList.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateCategoria extends StatefulWidget {
  @override
  State<CreateCategoria> createState() => _CreateCategoriaState();
}

class _CreateCategoriaState extends State<CreateCategoria> {
  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  File? selectedImage;

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriaList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {}
  }

  Future<String?> _uploadImage(String categoryTitle) async {
    try {
      if (selectedImage != null) {
        final fileName = 'categoriablog/$categoryTitle-${DateTime.now()}.png';
        final firebaseStorageReference =
            FirebaseStorage.instance.ref().child(fileName);

        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        return downloadUrl;
      } else {
        return null;
      }
    } catch (error) {
      print("Error uploading image: $error");
      return null;
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Categoria'),
      ),
      body: BounceInRight(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SlideInUp(
            child: ListView(
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                    hintText: 'Titulo de la categoria',
                    icon: Icon(Icons.category),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                    hintText: 'Descripcion de la categoria',
                    icon: Icon(Icons.category),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                if (selectedImage != null) Image.file(selectedImage!),
                SizedBox(height: 32.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      final downloadUrl =
                          await _uploadImage(tituloController.text.trim());

                      CategoriaLibModel nuevaCategoria = CategoriaLibModel(
                        titulo: tituloController.text.trim(),
                        descripcion: descripcionController.text.trim(),
                        foto: downloadUrl ?? "", // URL de la imagen
                      );

                      await categorialibControllerLib.CrearCategoria(
                          nuevaCategoria);
                      _navigateList(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                50), // Agrega un BorderRadius de 10
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'CREAR',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                    width:
                        16), // Agrega un espacio entre el texto y el botón "Cancelar"
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/category');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Color de fondo para el botón "Cancelar"
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
