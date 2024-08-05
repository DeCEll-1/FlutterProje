// ignore_for_file: prefer_const_constructors, empty_catches, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:proje/GoogleCrab/GoogleAccountsHelper.dart';
import 'package:proje/Helpers/Misc.dart';
import 'package:proje/Pages/MainPage.dart';
import 'package:proje/Pages/StartRedirector.dart';
import 'package:proje/pages/AuthPage.dart';
import 'package:proje/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        "/accountPage": (context) => AuthPage(title: 'Hesabım'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = "proje";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Sign In",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  GoogleAccountsHelper.signInWithGoogle().then((value) {
                    Misc.MoveAndRemovePast(context, Redirector());
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Redirector()));
                  });
                },
              )
            ],
          ),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.all(Radius.circular(5))),
          margin: EdgeInsets.fromLTRB(0, 160, 0, 160),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
      ),
    );
  }
}
