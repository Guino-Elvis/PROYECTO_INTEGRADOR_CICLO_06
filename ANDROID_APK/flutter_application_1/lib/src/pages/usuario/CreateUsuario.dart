import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/UsuarioController.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/pages/usuario/UsuarioList.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateUsuario extends StatefulWidget {
  @override
  State<CreateUsuario> createState() => _CreateUsuarioState();
}

class _CreateUsuarioState extends State<CreateUsuario> {
  UsuarioController usuarioController = UsuarioController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // final TextEditingController fotoController = TextEditingController();
  File? selectedImage;
  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioList()),
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
          FirebaseStorage.instance.ref().child('usuario/${DateTime.now()}.png');
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

  String?
      selectedRole; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> roles = [
    'admin',
    'user',
    'docente',
    'librero'
  ]; // Definir la lista de roles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario'),
      ),
      // drawer: MyDrawer(accountName: "Usuario"),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre del usuario',
                icon: Icon(Icons.person_add),
              ),
            ),
            // SizedBox(height: 16.0),
            // TextFormField(
            //   controller: roleController,
            //   decoration: InputDecoration(
            //     labelText: 'Rol',
            //     hintText: 'Rol del usuario',
            //     icon: Icon(Icons.category_outlined),
            //   ),
            // ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedRole,
              onChanged: (String? newValue) {
                // Aquí puedes manejar el cambio de valor seleccionado
                setState(() {
                  selectedRole = newValue;
                });
              },
              items: roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Rol',
                hintText: 'Selecciona un rol',
                icon: Icon(Icons.category_outlined),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Gmail -o- Hotmail ***',
                hintText: 'Correo del usuario',
                icon: Icon(Icons.email_outlined),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Contraseña del usuario',
                icon: Icon(Icons.category_outlined),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirma la contraseña',
                hintText: 'Confirma la contraseña del usuario',
                icon: Icon(Icons.password),
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
                  usuarioController.CrearUsuario(
                    nameController.text.trim(),
                    roleController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    confirmPasswordController.text.trim(),
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
                  Navigator.pushNamed(context, '/usuario');
                },
                style: ElevatedButton.styleFrom(
                  primary:
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
    );
  }
}
