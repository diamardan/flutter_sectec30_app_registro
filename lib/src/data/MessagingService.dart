import 'package:sectec30_app_registro/src/constants/constants.dart';
import 'package:sectec30_app_registro/src/models/notification_model.dart';
import 'package:sectec30_app_registro/src/models/subscription_model.dart';
import 'package:sectec30_app_registro/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final school = AppConstants.fsCollectionName;

  subscribeToTopics(Registration r) {
    Subscription subscription = Subscription.fromRegistration(r);

    //print(topicsNames.toString());

    /* FCM subscriptions to topics */
    print(subscription.careerTopic.toString());
    print(subscription.gradeTopic.toString());

    print(subscription.groupTopic.toString());

    print(subscription.turnTopic.toString());

    print(subscription.schoolTopic.toString());

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
    setTopics(r.id, subscription.toList());
  }

  unsubscribeFromTopics(Registration r) {
    Subscription subscription = Subscription.fromRegistration(r);

    //print(topicsNames.toString());

    /* FCM subscriptions to topics */
    if (subscription.careerTopic != "none")
      messaging.unsubscribeFromTopic(subscription.careerTopic);
    if (subscription.gradeTopic != "none")
      messaging.unsubscribeFromTopic(subscription.gradeTopic);
    if (subscription.groupTopic != "none")
      messaging.unsubscribeFromTopic(subscription.groupTopic);
    if (subscription.turnTopic != "none")
      messaging.unsubscribeFromTopic(subscription.turnTopic);

    messaging.unsubscribeFromTopic(school);

    /* save topics on firestore */
    unsetTopics(r.id);
  }

  Future<void> setTopics(String docId, List topics) {
    print("topics:");
    print(topics);
    return firestore
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(docId)
        .update({"fcm_topics": topics});
  }

  Future<void> unsetTopics(String docId) {
    return firestore
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(docId)
        .update({"fcm_topics": []});
  }

  /* Future<void> addNotification(String docId, Notification notification) async {
    await firestore
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(docId)
        .collection("notifications")
        .doc(notification.messageId)
        .set(notification.toJson())
        .then((value) => {print('mi docId en addNotification es:  $docId')});
  } */

  Future<Map<String, dynamic>> getMessage(String messageId) async {
    try {
      var result = await firestore
          .collection("schools")
          .doc(school)
          .collection("fcm_messages")
          .doc(messageId)
          .get();
      if (result.exists)
        return result.data();
      else
        return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
