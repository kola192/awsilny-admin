import 'package:flutter/material.dart';

var containerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  boxShadow: const [
    BoxShadow(
      color: Color.fromARGB(255, 213, 225, 243),
      offset: Offset(
        2.0,
        2.0,
      ),
      blurRadius: 13.0,
      spreadRadius: 0.0,
    ), //BoxShadow
    BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ],
);
