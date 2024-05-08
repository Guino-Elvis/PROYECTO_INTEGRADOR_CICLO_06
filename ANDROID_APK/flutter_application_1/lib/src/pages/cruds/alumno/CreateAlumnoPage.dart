import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/component/user/drawer/drawers.dart';
import 'package:flutter_application_1/src/controller/AlumnoController.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/AlumnoList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateAlumnoPage extends StatefulWidget {
  @override
  State<CreateAlumnoPage> createState() => _CreateAlumnoPageState();
}

class _CreateAlumnoPageState extends State<CreateAlumnoPage> {
  AlumnoController alumnoController = AlumnoController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  // final TextEditingController fotoController = TextEditingController();
  File? selectedImage;
  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlumnoList()),
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
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child('alumno/${DateTime.now()}.png');
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
        title: Text('Crear Alumno'),
      ),
      drawer: NavigationDrawerWidget(), //sidebar

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre del Alumno',
                icon: Icon(Icons.person_add),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellidos',
                hintText: 'Apellidos del alumno.',
                icon: Icon(Icons.person_add),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: dniController,
              decoration: InputDecoration(
                labelText: 'DNI',
                hintText: 'DNI del Alumno',
                icon: Icon(Icons.person_add),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: codigoController,
              decoration: InputDecoration(
                labelText: 'Codigo',
                hintText: 'Codigo del Alumno',
                icon: Icon(Icons.person_add),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: correoController,
              decoration: InputDecoration(
                labelText: 'Correo',
                hintText: 'Correo del Alumno',
                icon: Icon(Icons.person_add),
              ),
            ),
            SizedBox(height: 16.0),
            // SizedBox(height: 16.0),
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
                  // Primero, carga la imagen en Firebase Storage
                  final downloadUrl = await _uploadImage();
                  alumnoController.CrearAlumno(
                    nombreController.text.trim(),
                    apellidoController.text.trim(),
                    dniController.text.trim(),
                    codigoController.text.trim(),
                    correoController.text.trim(),
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
                 backgroundColor: Colors.red,
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
    );
  }
}
