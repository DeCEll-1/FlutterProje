import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key, this.title = ""});

  String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Text("balls");
  }
}
