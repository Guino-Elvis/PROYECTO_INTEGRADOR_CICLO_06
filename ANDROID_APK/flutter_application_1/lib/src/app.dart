// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/src/pages/alumno/AlumnoList.dart';
// import 'package:flutter_application_1/src/pages/auth/LoginPage.dart';
// import 'package:flutter_application_1/src/pages/auth/RegisterPage.dart';
// import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
// import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
// import 'package:flutter_application_1/src/pages/libros/pages/ui/Favoritos.dart';
// import 'package:flutter_application_1/src/pages/usuario/UsuarioList.dart';
// import 'package:flutter_application_1/src/pages/categoria/CategoriaList.dart';
// import 'package:flutter_application_1/src/view/AdminHomePage.dart';
// import 'package:flutter_application_1/src/view/HomePage.dart';
// import 'package:flutter_application_1/src/view/UserHomePage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';


// Widget _defaultHome =  const LoginPage();
// class MyApp extends ConsumerWidget {
//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//      // Ocultar los botones de navegación y hacer que la barra de notificaciones sea transparente
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
//     // Ocultar los botones de navegación después de 1 o 2 segundos
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
//     // final currentAppTheme = ref.watch(currentAppThemeNotifierProvider);
//     return MaterialApp(
//       title: ' APIS APLICACION',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.light(),
//         // darkTheme: ThemeData.dark(),
//         // themeMode: ThemeMode.system, // Puedes ajustar esto según tus necesidades
//       initialRoute: '/',
//       routes: {
//         '/': (context) => _defaultHome,
//         '/login': (context) => const LoginPage(),
//         '/register': (context) => const RegisterPage(),
//         '/home': (context) =>  HomePage(),
//         '/category': (context) => const CategoriaList(),
//         '/alumno': (context) => const AlumnoList(),
//         '/usuario': (context) => const UsuarioList(),
//         '/admin_home': (context) => AdminHomePage(),
//         '/docente_home': (context) => const UsuarioList(),
//         '/panadero_home': (context) => const UsuarioList(),
//         '/user_home': (context) =>  UserHomePage(),
//         //LIBRO RUTAS
//         '/librohome': (context) =>  Inicio(),
//         '/favoritos': (context) => const Favoritos(),
//         '/detalle': (context) => const Detalle(),
//         },
//       // home: CategoriaList(),
//     );
//   }

// }
