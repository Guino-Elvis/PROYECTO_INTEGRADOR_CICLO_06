// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/config/theme.dart';

// import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
// import 'package:icons_flutter/icons_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// // import 'package:flutter_icons/flutter_icons';
// class MyDrawer extends StatefulWidget {
//   @override
//   _MyDrawerState createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   // final ColorProvider colorProvider = ColorProvider();
//   // bool isDiurno = true;

//   String accountEmail = "";
//   String accountName = "";
//   String accountFoto = "";

//   // void toggleTheme() {
//   //   setState(() {
//   //     isDiurno = !isDiurno;
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     loadUserProfile();
//   }

//   Future<void> loadUserProfile() async {
//     final loginDetails = await ShareApiTokenService.loginDetails();

//     if (loginDetails != null) {
//       setState(() {
//         accountName = loginDetails.user?.name ?? "";
//         accountEmail = loginDetails.user?.email ?? "";
//         accountFoto = loginDetails.user?.foto ?? "";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//     final themeColors = themeProvider.getThemeColors();
//     Color iconColor;

// if (themeProvider.isDiurno) {
//   iconColor = themeProvider.getThemeColors()[themeProvider.getThemeColors().indexOf(ThemeProvider.colorblack)];
// } else {
//   iconColor = themeProvider.getThemeColors()[themeProvider.getThemeColors().indexOf(ThemeProvider.colorwhite)];
// }

//     return Drawer(
//       child: Container(
//         color: themeProvider.isDiurno ? themeColors[0] : themeColors[3],
//         child: ListView(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 160,
//                   width: 420,
//                   child: Image.asset(
//                     "assets/fondologin2.jpg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 UserAccountsDrawerHeader(
//                   accountName: Text(accountName),
//                   accountEmail: Text(accountEmail),
//                   currentAccountPicture: accountFoto.isEmpty
//                       ? Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 2.0,
//                             ),
//                           ),
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: Icon(Icons.person),
//                           ),
//                         )
//                       : Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 3.0,
//                             ),
//                           ),
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(accountFoto),
//                           ),
//                         ),
//                   decoration: BoxDecoration(
//                     color: HexColor("#0e1b4d").withOpacity(0.8),
//                   ),
//                   margin: EdgeInsets.all(0),
//                 ),
//               ],
//             ),
//             ListTile(
//               title: Text('Home'),
//               leading: IconTheme(
//                data: IconThemeData(color: iconColor),
//                 child: Icon(Icons.person)
//                 ),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/home', (route) => false);
//               },
//             ),
//             ListTile(
//               title: Text('Category'),
//               leading: Icon(Icons.category),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/category', (route) => false);
//               },
//             ),
//             ListTile(
//               title: Text('Alumnos'),
//               leading: Icon(Icons.person),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/alumno', (route) => false);
//               },
//             ),
//             ListTile(
//               title: Text('Usuarios'),
//               leading: Icon(Icons.person_4_rounded),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/usuario', (route) => false);
//               },
//             ),
//             ListTile(
//               title: Text('Libros'),
//               leading: Icon(Icons.book_online),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, '/librohome', (route) => false);
//               },
//             ),
//             Divider(),
// // ...

//             Container(
//               margin: EdgeInsets.only(left: 15),
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     themeProvider.isDiurno
//                         ? CupertinoIcons.sun_max
//                         : CupertinoIcons.moon_circle,

//                     size: 30,

//                     color: themeProvider.isDiurno
//                         ? Colors.black
//                         : Colors.white, // Color del sol y la luna
//                   ),
//                   Switch(
//                     value: themeProvider.isDiurno,
//                     onChanged: (value) {
//                       themeProvider.toggleTheme();
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             ListTile(
//               title: Text('Logout'),
//               leading: Icon(Icons.logout),
//               onTap: () {
//                 ShareApiTokenService.logout(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
