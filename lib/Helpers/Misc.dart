// ignore_for_file: non_constant_identifier_names, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proje/main.dart';

class Misc {
  static void MoveAndRemovePast(var context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
