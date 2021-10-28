import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String title;
  String message;
  DateTime receivedDate;
  DateTime sentDate;
  String senderName;
  String receiverId;
  bool read;

  Notification(
      {this.title,
      this.message,
      this.receivedDate,
      this.sentDate,
      this.senderName,
      this.read});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"],
      message: json["message"],
      receivedDate: json["received_date"].toDate(),
      sentDate: json["sent_date"].toDate(),
      senderName: json["sender_name"],
      read: json["read"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "received_date": receivedDate,
        "sent_date": sentDate,
        "sender_name": senderName,
        "read": read,
      };
}
