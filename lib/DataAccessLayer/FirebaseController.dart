// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proje/DataAccessLayer/Note.dart';
import 'package:uuid/uuid.dart';

class FirebaseController {
  final noteCollection = FirebaseFirestore.instance.collection("Notes");

  void AddNote(Note note) {
    noteCollection.doc(note.CreationDate.hashCode.toString() + note.UserID).set({
      "Header": note.Header,
      "Content": note.Content,
      "CreationDate": note.CreationDate,
      "EditDate": note.EditDate,
      "UserID": note.UserID,
    });

    Fluttertoast.showToast(
        msg: "Note has been added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void UpdateNote(Note note) {
    try {
      noteCollection.doc(note.CreationDate.hashCode.toString() + note.UserID).set({
        "Header": note.Header,
        "Content": note.Content,
        "CreationDate": note.CreationDate,
        "EditDate": note.EditDate,
        "UserID": note.UserID,
      });

      Fluttertoast.showToast(
          msg: "Note has been updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (ex) {
      Fluttertoast.showToast(
          msg: "An error haappened when saving the note:\n" + ex.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void DeleteNote(Note note) {
    try {
      print(note.CreationDate.hashCode.toString() + note.UserID);
      noteCollection.doc(note.CreationDate.hashCode.toString() + note.UserID).delete().then((value) => {
            Fluttertoast.showToast(
                msg: "Note has been deleted successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0)
          });
    } catch (ex) {
      Fluttertoast.showToast(
          msg: "An error haappened when deleting the note:\n" + ex.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<List<Note>> getNotes(String UserID) async {
    Iterable<Map<String, dynamic>> carDocs;
    var snapshot = await noteCollection.get();
    carDocs = snapshot.docs.map((e) => e.data());

    List<Note> araclist = [];
    for (Map<String, dynamic> json in carDocs) {
      Note note = Note.fromJson(json);
      if (note.UserID == UserID) {
        araclist.add(note);
      }
    }
    return araclist;
  }
}
