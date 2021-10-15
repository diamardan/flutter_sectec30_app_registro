import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String title;
  String message;
  DateTime receivedDate;
  DateTime sentDate;
  String sender;
  bool read;

  Notification(
      {this.title,
      this.message,
      this.receivedDate,
      this.sentDate,
      this.sender,
      this.read});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"],
      message: json["message"],
      receivedDate: json["received_date"].toDate(),
      sentDate: json["sent_date"].toDate(),
      sender: json["sender"],
      read: json["read"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "received_date": receivedDate,
        "sent_date": sentDate,
        "sender": sender,
        "read": read,
      };
}
