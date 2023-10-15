import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/CategoriaController.dart';
import 'package:flutter_application_1/src/view/CategoriaList.dart';
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
      drawer: MyDrawer(accountName: "Usuario"),
      // drawer: MyDrawer(
      //     accountName: "Nombre Usuario",
      //     accountEmail:
      //         "usuario@example.com"), // Aquí proporciona los datos necesarios
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
                  primary: Colors.blue,
                ),
                onPressed: () async {
                  // Primero, carga la imagen en Firebase Storage
                  final downloadUrl = await _uploadImage();
                  categoriaController.CrearCategoria(
                    tituloController.text.trim(),
                    descripccionController.text.trim(),
                    downloadUrl ??
                        "", // Si downloadUrl es nulo, se usa una cadena vacía como valor predeterminado
                  );
                  _navigateList(context); // Utiliza _navigateList aquí
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
                        Navigator.pushNamed(context,
                            '/category'); // Navega a la ruta "categoria" al presionar "Cancelar"
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .red, // Color de fondo para el botón "Cancelar"
                      ),
                      child: Text("Cancelar",
                      style: TextStyle(
                          color: Colors.white,
                        
                        ),)
                      
                    ),
          ],
        ),
      ),
    );
  }
}
