import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart';
import 'package:cetis32_app_registro/src/models/subscription_model.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final school = AppConstants.fsCollectionName;

  suscribeToTopics(Registration reg) {
    Subscription subscription = _convertToTopicsNaming(reg);

    //print(topicsNames.toString());

    /* FCM subscriptions to topics */
    if (subscription.careerTopic != "none")
      messaging.subscribeToTopic(subscription.careerTopic);
    if (subscription.gradeTopic != "none")
      messaging.subscribeToTopic(subscription.gradeTopic);
    if (subscription.groupTopic != "none")
      messaging.subscribeToTopic(subscription.groupTopic);
    if (subscription.turnTopic != "none")
      messaging.subscribeToTopic(subscription.turnTopic);

    messaging.subscribeToTopic(school);

    /* save topics on firestore */
    saveTopics(reg.id, subscription);
  }

  setFCMToken(String regId, String deviceId, String token) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      var deviceRef = FirebaseFirestore.instance
          .collection("schools")
          .doc(school)
          .collection("registros")
          .doc(regId)
          .collection("devices")
          .doc(deviceId);
      transaction.update(deviceRef, {"fcm_token": token});
      var regRef = FirebaseFirestore.instance
          .collection("schools")
          .doc(school)
          .collection("registros")
          .doc(regId);
      transaction.update(regRef, {
        "fcm_tokens": FieldValue.arrayUnion([token])
      });
    });
  }

  Future<bool> existsFCMToken(String regId, String deviceId) async {
    var result = await FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(regId)
        .collection("devices")
        .doc(deviceId)
        .get();
    if (result.data()["fcm_token"] != null)
      return true;
    else
      return false;
  }

  Future<void> saveTopics(String docId, Subscription topics) {
    return firestore
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(docId)
        .update({"subscribed_to": topics.toJson()});
  }

  save(String docId, Notification notification) {
    firestore
        .collection("schools")
        .doc(school)
        .collection("notifications")
        .doc(docId)
        .collection("received_messages")
        .add(notification.toJson());
  }
}
// * * * * * * * * * * * * * * *

/* * * * utils functions * * * */

Subscription _convertToTopicsNaming(Registration reg) {
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

  return Subscription(
      careerTopic: career ?? "none",
      gradeTopic: grade ?? "none",
      groupTopic: group ?? "none",
      turnTopic: turn ?? "none",
      schoolTopic: "cetis32");
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
