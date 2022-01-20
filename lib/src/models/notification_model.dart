class Notification {
  String title;
  String message;
  DateTime receivedDate;
  DateTime sentDate;
  String senderName;
  String messageId;
  String receiverId;
  bool read;

  Notification(
      {this.title,
      this.message,
      this.receivedDate,
      this.sentDate,
      this.senderName,
      this.messageId,
      this.read});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["title"],
      message: json["message"],
      receivedDate: json["received_date"].toDate(),
      sentDate: json["sent_date"].toDate(),
      senderName: json["sender_name"],
      messageId: json["message_id"],
      read: json["read"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "received_date": receivedDate,
        "sent_date": sentDate,
        "sender_name": senderName,
        "message_id": messageId,
        "read": read,
      };
}
