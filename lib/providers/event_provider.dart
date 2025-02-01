import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

final eventProvider = StateNotifierProvider<EventNotifier, List<Event>>((ref) {
  return EventNotifier();
});

class EventNotifier extends StateNotifier<List<Event>> {
  EventNotifier() : super([]);

  final Box<Event> eventBox = Hive.box<Event>('events');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadEvents() async {
    final events = eventBox.values.toList();
    state = events;
  }

  Future<void> addRSVP(String eventId) async {
    final event = state.firstWhere((e) => e.id == eventId);
    event.attendeeCount++;
    eventBox.put(event.id, event);
    state = [...state];

    if (await isOnline()) {
      await firestore.collection('events').doc(eventId).update({'attendeeCount': event.attendeeCount});
    }
  }

  Future<bool> isOnline() async {
    return (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
  }

  Future<void> syncOfflineData() async {
    if (await isOnline()) {
      for (var event in state) {
        final doc = await firestore.collection('events').doc(event.id).get();
        if (doc.exists) {
          firestore.collection('events').doc(event.id).update({'attendeeCount': event.attendeeCount});
        } else {
          firestore.collection('events').doc(event.id).set({
            'title': event.title,
            'date': event.date,
            'attendeeCount': event.attendeeCount,
          });
        }
      }
    }
  }
}
