import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/AlumnoController.dart';
import 'package:flutter_application_1/src/pages/alumno/AlumnoList.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

class EditAlumno extends StatefulWidget {
  final List list;
  final int index;

  const EditAlumno({required this.list, required this.index});

  @override
  State<EditAlumno> createState() => _EditAlumnoState();
}

class _EditAlumnoState extends State<EditAlumno> {
  AlumnoController alumnoController = AlumnoController();

  late TextEditingController controllerid;
  late TextEditingController controllernombre;
  late TextEditingController controllerapellido;
  late TextEditingController controllerdni;
  late TextEditingController controllercodigo;
  late TextEditingController controllercorreo;
  late TextEditingController controllerfoto;
  File? selectedImage;
  String alumnoImageURL = "";

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlumnoList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controllerid = TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllernombre = TextEditingController(text: widget.list[widget.index]['nombre'].toString());
    controllerapellido = TextEditingController(text: widget.list[widget.index]['apellido'].toString());
    controllerdni = TextEditingController(text: widget.list[widget.index]['dni'].toString());
    controllercodigo = TextEditingController(text: widget.list[widget.index]['codigo'].toString());
    controllercorreo = TextEditingController(text: widget.list[widget.index]['correo'].toString());
    // Obtiene la URL de la imagen de la categoría que estás editando
    alumnoImageURL = widget.list[widget.index]['foto'];
    // Inicializa selectedImage con la URL de la foto existente
    selectedImage = File(alumnoImageURL);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // El usuario no seleccionó una nueva imagen.
    }
  }

  Future<void> _updateImageInFirebase() async {
    String newImageUrl = widget.list[widget.index]
        ['foto']; // Por defecto, se mantiene la imagen existente

    if (selectedImage != null) {
      final firebaseStorageReference = FirebaseStorage.instance
          .ref()
          .child('alumno/${DateTime.now()}.png');

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        // ignore: unnecessary_null_comparison
        if (downloadUrl != null) {
          newImageUrl =
              downloadUrl; // Si se selecciona una nueva imagen, se actualiza la URL
        }
      } catch (e) {
        // Maneja el error, por ejemplo, muestra un mensaje al usuario
        print("Error al cargar la imagen: $e");
      }
    }

    // Actualiza la categoría, incluyendo la URL de la imagen (ya sea la existente o la nueva)
    alumnoController.editarAlumno(
      controllerid.text.trim(),
      controllernombre.text.trim(),
      controllerapellido.text.trim(),
      controllerdni.text.trim(),
      controllercodigo.text.trim(),
      controllercorreo.text.trim(),
      newImageUrl,
    );

    _navigateList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar alumno"),
      ),
      drawer: MyDrawer(accountName: "Usuario"), //sidebar
      
      body: Form(
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

                Container(
                  margin: EdgeInsets.all(
                      8.0), // Agrega márgenes alrededor de la imagen
                  child: CachedNetworkImage(
                    imageUrl: alumnoImageURL.isNotEmpty
                        ? alumnoImageURL
                        : 'assets/nofoto.jpg',
                    placeholder: (context, url) =>
                        CircularProgressIndicator(), // Puedes personalizar el indicador de carga
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/nofoto.jpg'),
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllernombre,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "nombre",
                      labelText: "nombre",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerapellido,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "apellido",
                      labelText: "apellido",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerdni,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "dni",
                      labelText: "dni",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllercodigo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "codigo",
                      labelText: "codigo",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllercorreo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "correo",
                      labelText: "correo",
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
                         Navigator.pushNamed(context, '/alumnolist'); // Navega a la ruta "alumno"
                      },
                      child: Text("Cancelar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Color de fondo para el botón "Cancelar"
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
