// ignore_for_file: prefer_const_constructors, unnecessary_import, curly_braces_in_flow_control_structures, avoid_print, avoid_unnecessary_containers, dead_code

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proje/DataAccessLayer/FirebaseController.dart';
import 'package:proje/DataAccessLayer/Note.dart';
import 'package:proje/Pages/NoteEditing.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Note>? notes;

  @override
  void initState() {
    super.initState();
    load();
  }

  load() {
    notes = null;
    FirebaseController().getNotes(FirebaseAuth.instance.currentUser!.uid).then((value) => {
          setState(() {
            notes = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (notes == null)
      return Container(
        child: Center(child: getLoadingAnimation()),
      );
    return Scaffold(
        body: Center(
      child: getList(),
    ));
  }

  getList() {
    TextStyle textStyle = TextStyle(fontSize: 24);

    return ListView.builder(
        itemCount: notes?.length,
        itemBuilder: (BuildContext context, int index) {
          Note note = notes![index];

          return ListTile(
            leading: const Icon(Icons.list),
            title: Text(
              note.Header,
              style: textStyle,
            ),
            onTap: () {
              // stuff
              Navigator.of(context).push(_routeCreate(note));
            },
            style: ListTileStyle.drawer,
          );
        });
  }

  Route _routeCreate(Note note) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => NoteEditing(note: note),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  getLoadingAnimation() {
    Color color = Colors.red;
    Color altColor = Colors.black;
    double size = 130;
    int number = Random().nextInt(20);

    print(number);
    switch (number) {
      case 0:
        return LoadingAnimationWidget.waveDots(color: color, size: size);
      case 1:
        return LoadingAnimationWidget.inkDrop(color: color, size: size);
      case 2:
        return LoadingAnimationWidget.twistingDots(leftDotColor: color, rightDotColor: altColor, size: size);
      case 3:
        return LoadingAnimationWidget.threeRotatingDots(color: color, size: size);
      case 4:
        return LoadingAnimationWidget.staggeredDotsWave(color: color, size: size);
      case 5:
        return LoadingAnimationWidget.fourRotatingDots(color: color, size: size);
      case 6:
        return LoadingAnimationWidget.fallingDot(color: color, size: size);
      case 7:
        return LoadingAnimationWidget.prograssiveDots(color: color, size: size);
      case 8:
        return LoadingAnimationWidget.discreteCircle(color: color, size: size);
      case 9:
        return LoadingAnimationWidget.threeArchedCircle(color: color, size: size);
      case 10:
        return LoadingAnimationWidget.bouncingBall(color: color, size: size);
      case 11:
        return LoadingAnimationWidget.flickr(leftDotColor: color, rightDotColor: altColor, size: size);
      case 12:
        return LoadingAnimationWidget.hexagonDots(color: color, size: size);
      case 13:
        return LoadingAnimationWidget.beat(color: color, size: size);
      case 14:
        return LoadingAnimationWidget.twoRotatingArc(color: color, size: size);
      case 15:
        return LoadingAnimationWidget.horizontalRotatingDots(color: color, size: size);
      case 16:
        return LoadingAnimationWidget.newtonCradle(color: color, size: size);
      case 17:
        return LoadingAnimationWidget.stretchedDots(color: color, size: size);
      case 18:
        return LoadingAnimationWidget.halfTriangleDot(color: color, size: size);
      case 19:
        return LoadingAnimationWidget.dotsTriangle(color: color, size: size);
      default:
    }
  }
}
