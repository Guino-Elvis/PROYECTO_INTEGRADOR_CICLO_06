import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/CategoriaController.dart';
import 'package:flutter_application_1/view/CategoriaList.dart';

class CrearCategoriaPage extends StatefulWidget {
  @override
  State<CrearCategoriaPage> createState() => _CrearCategoriaPageState();
}

class _CrearCategoriaPageState extends State<CrearCategoriaPage> {
  CategoriaController categoriaController = CategoriaController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripccionController = TextEditingController();
  final TextEditingController fotoController = TextEditingController();

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
            TextFormField(
              controller: fotoController,
              decoration: InputDecoration(
                labelText: 'Imagen',
                hintText: 'Imagen o foto de la categoría',
                icon: Icon(Icons.add_to_photos),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(246, 104, 36, 24),
              ),
              onPressed: () {
                categoriaController.CrearCategoria(
                  tituloController.text.trim(),
                  descripccionController.text.trim(),
                  fotoController.text.trim(),
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
