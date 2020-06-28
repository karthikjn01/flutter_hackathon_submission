import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  String message;
  String id;
  List<String> likedBy;
  DateTime time;
  Map<dynamic, dynamic> author;

  Tip.fromJson(this.message, this.likedBy, this.time, this.author);

  Tip.fromMap(map, id) {
    this.id = id;
    this.message = map["message"];
    this.likedBy =
        map["likedBy"].map((s) => s as String).toList().cast<String>().toList();
    this.time = DateTime.parse(map["time"].toDate().toString());
    this.author = map["author"];
  }

  void push() {
    Firestore.instance.collection("Tips").add({
      "message": this.message,
      "author": this.author,
      "likedBy": this.likedBy,
      "time": this.time,
    }).then((value) => this.id = value.documentID);
  }
}
