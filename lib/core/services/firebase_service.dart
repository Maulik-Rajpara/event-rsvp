import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event.dart';
import '../../models/rsvp.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Event>> getEvents() {
    return _firestore.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList();
    });
  }

  Future<void> updateRSVP(RSVP rsvp) async {
    await _firestore
        .collection('rsvps')
        .doc(rsvp.eventId)
        .set(rsvp.toMap(), SetOptions(merge: true));
  }

  Stream<List<RSVP>> getRSVPs(String userId) {
    return _firestore.collection('rsvps').where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => RSVP.fromMap(doc.data())).toList();
    });
  }

  // Add a new event to Firebase
  Future<void> addEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).set(event.toMap());
  }
}
