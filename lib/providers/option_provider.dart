

import 'package:flutter/cupertino.dart';

class Option extends ChangeNotifier{
  bool _showBackToTopButton = true;


  changeButton(){
    _showBackToTopButton = false;
    notifyListeners();
  }
}