import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/component/BottomNavBarFlex.dart';
import 'package:flutter_application_1/src/component/BottomNavBarFlex2.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/service/authService/ApiService.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    Color iconColor;

    if (themeProvider.isDiurno) {
      iconColor = themeProvider.getThemeColors()[
          themeProvider.getThemeColors().indexOf(ThemeProvider.colorwhite)];
    } else {
      iconColor = themeProvider.getThemeColors()[
          themeProvider.getThemeColors().indexOf(ThemeProvider.colorblack)];
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page h'),
        elevation: 0,
        actions: [
          IconTheme(
            data: IconThemeData(color: iconColor),
            child: IconButton(
              onPressed: () {
                ShareApiTokenService.logout(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      backgroundColor: themeProvider.isDiurno ? themeColors[0] : themeColors[3],
      body: Column(
        children: [
          Expanded(
            child: userProfile(),
          ),
          Container(
            height: 60.0, // Ajusta la altura deseada para el BottomNavBarFlex
            child: BottomNavBarFlex2(
              onPressedSpecialButtonItem: () {},
              onPressedSpecialButtonExel: () {},
              onPressedSpecialButtonPdf: () {},
              buttonColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget userProfile() {
    return FutureBuilder<List<String>>(
      future: ApiService.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final emailList = snapshot.data!;

            return ListView.builder(
              itemCount: emailList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(emailList[index], style: TextStyle(fontSize: 16)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
