import 'package:flutter/foundation.dart';


class LeftNotifier with ChangeNotifier {
  double _left = 0.0;
  bool _showButton = false;

  double get left => _left;
  set left(double value) {
    _left = value;
    if (_left < -80) {
      _left = -80;
    }
    if (_left > 0) {
      _left = 0;
    }
    
    // Controlar la visibilidad del botón
    _showButton = _left < 0;
    
    notifyListeners();
  }
  
  bool get showButton => _showButton;

  
}