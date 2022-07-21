import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class SingleUser extends ChangeNotifier {
  var user;
  void setUser(data) {
    user = data;
  }
}
