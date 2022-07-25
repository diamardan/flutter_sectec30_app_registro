import 'package:firebase_messaging/firebase_messaging.dart';

class Notification {
  String serverMessageId;
  String title;
  String message;
  DateTime sentDate;
  DateTime receivedDate;
  String inputMode;
  bool read;
  String origin;
  // only for notification from user
  final String senderName;
  final String messageId;
  final bool haveAttachments;

  Notification(
      {this.serverMessageId,
      this.title,
      this.message,
      this.sentDate,
      this.receivedDate,
      this.inputMode,
      this.read,
      this.origin,
      this.senderName,
      this.messageId,
      this.haveAttachments});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      serverMessageId: json["server_message_id"],
      title: json["title"],
      message: json["message"],
      receivedDate: json["received_date"].toDate(),
      sentDate: json["sent_date"].toDate(),
      inputMode: json["input_mode"],
      read: json["read"],
      origin: json["origin"],
      senderName: json["sender_name"],
      messageId: json["message_id"],
      haveAttachments: json["have_attachments"],
    );
  }

  factory Notification.fromRemoteMessage(RemoteMessage message) {
    return Notification(
        serverMessageId: message.messageId,
        title: message.notification.title,
        message: message.notification.body,
        receivedDate: DateTime.now(),
        sentDate: message.sentTime,
        origin: message.data["origin"],
        senderName: message.data["sender"],
        messageId: message.data["messageId"],
        haveAttachments:
            message.data["haveAttachments"] == "yes" ? true : false,
        inputMode: "background",
        read: false);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> notification = {
      "title": title,
      "message": message,
      "received_date": receivedDate,
      "sent_date": sentDate,
      "input_mode": inputMode,
      "read": read,
      "origin": origin,
    };
    if (origin == "message") {
      notification = {
        ...notification,
        "sender_name": senderName,
        "message_id": messageId,
        "have_attachments": haveAttachments
      };
    }
    return notification;
  }
}
