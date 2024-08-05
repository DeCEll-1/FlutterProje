// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proje/Pages/MainPage.dart';
import 'package:proje/main.dart';

class Redirector extends StatefulWidget {
  const Redirector({super.key});

  @override
  State<Redirector> createState() => _RedirectorState();
}

class _RedirectorState extends State<Redirector> {
  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser == null)
        ?
        // throw to login page
        MyHomePage()
        :
        // actual app
        MainPage();
  }
}
