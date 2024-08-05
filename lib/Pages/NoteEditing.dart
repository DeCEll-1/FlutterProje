// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_import, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proje/DataAccessLayer/FirebaseController.dart';
import 'package:proje/DataAccessLayer/Note.dart';

class NoteEditing extends StatefulWidget {
  NoteEditing({super.key, required this.note});

  Note note;

  @override
  State<NoteEditing> createState() => _NoteEditingState();
}

class _NoteEditingState extends State<NoteEditing> {
  TextEditingController headerController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void initState() {
    super.initState();
    headerController.text = widget.note.Header;
    contentController.text = widget.note.Content;
  }

  DeleteNote() async {
    FirebaseController().DeleteNote(widget.note);
  }

  UpdateNote() async {
    Note note = new Note(
      Header: headerController.text,
      Content: contentController.text,
      CreationDate: widget.note.CreationDate,
      EditDate: Timestamp.now(),
      UserID: FirebaseAuth.instance.currentUser!.uid,
    );
    FirebaseController().UpdateNote(note);
    setState(() {
      headerController.text = note.Header;
      contentController.text = note.Content;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("Update Note", style: new TextStyle(fontSize: 20)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: UpdateNote, child: Text("Update Note")),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: DeleteNote,
                  style: ElevatedButton.styleFrom(backgroundColor: cs.tertiary),
                  child: Text(
                    "Delete Note",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
