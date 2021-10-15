import 'package:cetis32_app_registro/src/models/notification_model.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final school = "cetis32";

  suscribeToTopics(Registration reg) {
    Map<String, String> topicsNames = _convertToTopicsNaming(reg);

    print(topicsNames.toString());

    /* FCM subscriptions to topics */
    if (topicsNames["career"] != null)
      messaging.subscribeToTopic(topicsNames["career"]);
    if (topicsNames["grade"] != null)
      messaging.subscribeToTopic(topicsNames["grade"]);
    if (topicsNames["group"] != null)
      messaging.subscribeToTopic(topicsNames["group"]);
    if (topicsNames["turn"] != null)
      messaging.subscribeToTopic(topicsNames["turn"]);
    messaging.subscribeToTopic(school);

    /* save topics on firestore */
    saveTopics(reg.id, topicsNames);
  }

  saveTopics(docId, topics) {
    return firestore
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(docId)
        .update({"subscribed_to": topics});
  }

  save(Notification notification) {
    firestore
        .collection("schools")
        .doc(school)
        .collection("notifications")
        .add(notification.toJson());
  }
}
// * * * * * * * * * * * * * * *

/* * * * utils functions * * * */

Map<String, String> _convertToTopicsNaming(Registration reg) {
  String career;
  String grade;
  String group;
  String turn;

  if (reg.career != null) career = _replaceChars(reg.career.toLowerCase());

  if (reg.grade != null) {
    grade = "grade-${reg.grade}";
  }

  if (reg.group != null) {
    group = reg.group.toLowerCase();
    group = "group-$group";
  }

  if (reg.turn != null) turn = _replaceChars(reg.turn.toLowerCase());

  return {
    "topic-career": career ?? "no-career",
    "topic-grade": grade ?? "no-grade",
    "topic-group": group ?? "no-group",
    "topic-turn": turn ?? "no-turn",
  };
}

String _replaceChars(word) {
  word = word.replaceAll(RegExp(' +'), "-");
  word = word.replaceAll("á", "a");
  word = word.replaceAll("é", "e");
  word = word.replaceAll("í", "i");
  word = word.replaceAll("ó", "o");
  word = word.replaceAll("ú", "u");

  return word;
}
