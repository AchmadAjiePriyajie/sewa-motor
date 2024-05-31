import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sewa_motor/model/notification.dart';

class NotificationServices {
  final CollectionReference notif =
      FirebaseFirestore.instance.collection('notification');

  Future<void> addNotif(String title, String message,String userId, String transactionId) {
    return notif.add(
      Notification(
        title: title,
        userId: userId,
        transactionId: transactionId,
        message: message,
        timestamp: Timestamp.now(),
      ).toJson(),
    );
  }

  Stream<QuerySnapshot> getNotifStream(String userId) {
    final notifStream = notif
        .orderBy('timestamp', descending: true).where('userId', isEqualTo: userId)
        .snapshots();
    return notifStream;
  }


}
