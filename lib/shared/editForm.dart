import 'package:flutter/material.dart';

class EditForm with ChangeNotifier {
  bool showsheet2 = false;

  get show => showsheet2;

  void toggleShow() {
    showsheet2 = !showsheet2;
    notifyListeners();
  }
}