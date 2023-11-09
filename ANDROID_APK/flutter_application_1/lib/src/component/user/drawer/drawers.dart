import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String accountEmail = "";
  String accountName = "";
  String accountFoto = "";

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final loginDetails = await ShareApiTokenService.loginDetails();

    if (loginDetails != null) {
      setState(() {
        accountName = loginDetails.user?.name ?? "";
        accountEmail = loginDetails.user?.email ?? "";
        accountFoto = loginDetails.user?.foto ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //drawertheme
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: themeProvider.isDiurno ? themeColors[0] : themeColors[6],
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Portal',
                    icon: Icons.school_outlined,
                    onTap: () {
                      // Redirige a la ruta 'people' o la ruta que desees.
                      Navigator.of(context).pushNamed('/colegiohome');
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Libros',
                    icon: CupertinoIcons.book,
                    onTap: () {
                      // Redirige a la ruta 'favourites' o la ruta que desees.
                      Navigator.of(context).pushNamed('/librohome');
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Workflow',
                    icon: Icons.workspaces_outline,
                    onTap: () {
                      // Redirige a la ruta 'workflow' o la ruta que desees.
                      Navigator.of(context).pushNamed('/workflow');
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Updates',
                    icon: Icons.update,
                    onTap: () {
                      // Redirige a la ruta 'updates' o la ruta que desees.
                      Navigator.of(context).pushNamed('/updates');
                    },
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          themeProvider.isDiurno
                              ? CupertinoIcons.sun_max
                              : CupertinoIcons.moon_circle,

                          size: 30,

                          color: themeProvider.isDiurno
                              ? Colors.white
                              : Colors.white, // Color del sol y la luna
                        ),
                        Switch(
                          value: themeProvider.isDiurno,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Plugins',
                    icon: Icons.account_tree_outlined,
                    onTap: () {
                      // Redirige a la ruta 'plugins' o la ruta que desees.
                      Navigator.of(context).pushNamed('/plugins');
                    },
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Notifications',
                  //   icon: Icons.notifications_outlined,
                  //   onTap: () {
                  //     // Redirige a la ruta 'notifications' o la ruta que desees.
                  //     Navigator.of(context).pushNamed('/notifications');
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onTap: () {
                      // Redirige a la ruta 'notifications' o la ruta que desees.

                      ShareApiTokenService.logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              child: Icon(Icons.edit, color: Colors.white),
            )
          ],
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }
}
