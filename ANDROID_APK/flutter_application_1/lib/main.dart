import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/CategoriaList.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCVq_E2pZ5FD8Q6RWSKEmnjmZ8WVrh7PkA",
      authDomain: "proyectointegrador-e2212.firebaseapp.com",
      projectId: "proyectointegrador-e2212",
      storageBucket: "proyectointegrador-e2212.appspot.com",
      messagingSenderId: "4455056114",
      appId: "1:4455056114:web:aa0af31fa1f65548e9c66b",
      measurementId: "G-MDZRF01NHQ"
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD CATEGORIA API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CategoriaList(),
    );
  }
}

