import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/CategoriaController.dart';
import 'package:flutter_application_1/view/CategoriaList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CrearCategoriaPage extends StatefulWidget {
  @override
  State<CrearCategoriaPage> createState() => _CrearCategoriaPageState();
}

class _CrearCategoriaPageState extends State<CrearCategoriaPage> {
  CategoriaController categoriaController = CategoriaController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripccionController = TextEditingController();
  // final TextEditingController fotoController = TextEditingController();
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
    } else {
      // El usuario no seleccionó una imagen, puedes mostrar un mensaje de error.
    }
  }

  Future<String?> _uploadImage() async {
    if (selectedImage != null) {
      final firebaseStorageReference = FirebaseStorage.instance
          .ref()
          .child('categoriablog/${DateTime.now()}.png');
      await firebaseStorageReference.putFile(selectedImage!);
      final downloadUrl = await firebaseStorageReference.getDownloadURL();
      return downloadUrl;
    } else {
      return null; // Devuelve null en caso de que la imagen no se cargue.
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Aquí puedes procesar la imagen seleccionada.
      // Por ejemplo, puedes mostrarla en la interfaz de usuario.
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {
      // El usuario canceló la selección.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                hintText: 'Título de la categoría',
                icon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: descripccionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                hintText: 'Descripción de la categoría',
                icon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            if (selectedImage != null) Image.file(selectedImage!),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 104, 36, 24),
              ),
              onPressed: () async {
                // Primero, carga la imagen en Firebase Storage
                final downloadUrl = await _uploadImage();

                // // Luego, llama a la función para crear la categoría solo si la imagen se cargó con éxito
                // if (downloadUrl != null) {
                //   categoriaController.CrearCategoria(
                //     tituloController.text.trim(),
                //     descripccionController.text.trim(),
                //     downloadUrl,
                //   );
                //   _navigateList(context); // Utiliza _navigateList aquí
                // } else {
                //   // Aquí puedes manejar un caso en el que la carga de la imagen falló.
                // }
                // Luego, llama a la función para crear la categoría
                categoriaController.CrearCategoria(
                  tituloController.text.trim(),
                  descripccionController.text.trim(),
                  downloadUrl ?? "", // Si downloadUrl es nulo, se usa una cadena vacía como valor predeterminado
                );

                _navigateList(context); // Utiliza _navigateList aquí
              },
              child: Text(
                'CREAR',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
