import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String Content;
  final Timestamp CreationDate;
  final Timestamp EditDate;
  final String Header;
  final String UserID;
  Note({this.Content = "", required this.CreationDate, required this.EditDate, required this.Header, required this.UserID});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(Content: json['Content'], CreationDate: json['CreationDate'], EditDate: json['EditDate'], Header: json['Header'], UserID: json['UserID']);
  }
}
