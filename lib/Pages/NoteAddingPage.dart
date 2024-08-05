// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, unnecessary_new, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proje/DataAccessLayer/FirebaseController.dart';
import 'package:proje/DataAccessLayer/Note.dart';

class NoteAddingPage extends StatefulWidget {
  const NoteAddingPage({super.key});

  @override
  State<NoteAddingPage> createState() => _NoteAddingPageState();
}

class _NoteAddingPageState extends State<NoteAddingPage> {
  TextEditingController headerController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  AddNote() async {
    Note note = new Note(
      Header: headerController.text,
      Content: contentController.text,
      CreationDate: Timestamp.now(),
      EditDate: Timestamp.now(),
      UserID: FirebaseAuth.instance.currentUser!.uid,
    );
    FirebaseController().AddNote(note);
    setState(() {
      headerController.text = "";
      contentController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("Add New Note", style: new TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                controller: headerController,
                decoration: InputDecoration(
                  labelText: "Note Header",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                maxLines: null,
                controller: contentController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  labelText: "Note Content",
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: AddNote, child: Text("Save Note")),
          ],
        ),
      ),
    );
  }
}
