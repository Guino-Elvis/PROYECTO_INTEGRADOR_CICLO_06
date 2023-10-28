import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDiurno = true;

  bool get isDiurno => _isDiurno;

  void toggleTheme() {
    _isDiurno = !_isDiurno;
    notifyListeners();
  }

  static Color color1 = HexColor("#0e1b4d");
  static Color color2 = Colors.blue;
  static Color color3 = Colors.green;
  static Color color4 = Colors.orange;
  static Color color5 = Colors.purple;
  static Color color6 = Colors.yellow;
  static Color color7 = Colors.black;
  static Color color8 = Colors.white;
  //iconos 
  static Color colorwhite = Colors.white;
  static Color colorblack = Colors.black;
  List<Color> diatheme() {
    return [color1, color2, color3,color8,colorblack]; // Define los colores para el tema diurno
  }

  List<Color> nochetheme() {
    return [color4, color5, color6, color7,colorwhite]; // Define los colores para el tema nocturno
  }

  List<Color> getThemeColors() {
    return _isDiurno ? diatheme() : nochetheme();
  }
}