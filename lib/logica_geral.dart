
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogicaGeral{
  void navigateTo(
      {required BuildContext context,
        required Widget destination,
        required String tipo}) {
    if (tipo == 'pushreplacement') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => destination),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => destination),
      );
    }
  }
}