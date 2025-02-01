import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/firebase_service.dart';
import '../../core/services/hive_service.dart';
import '../../models/event.dart';
import '../../models/rsvp.dart';


class EventViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService;
  final HiveService _hiveService;

  EventViewModel({required FirebaseService firebaseService, required HiveService hiveService})
      : _firebaseService = firebaseService,
        _hiveService = hiveService;

  List<Event> events = [];
  List<RSVP> rsvps = [];

  Future<void> loadEvents() async {
    events = _hiveService.getEvents();
    notifyListeners();
  }

  Future<void> syncEvents() async {
    final eventsStream = _firebaseService.getEvents();
    eventsStream.listen((events) {
      for (var event in events) {
        _hiveService.saveEvent(event);
      }
      loadEvents();
    });
  }

  Future<void> updateRSVP(RSVP rsvp) async {
    await _firebaseService.updateRSVP(rsvp);
    await _hiveService.saveRSVP(rsvp);
    notifyListeners();
  }

  Future<void> syncRSVPs() async {
    // Handle syncing of RSVP data here
    final FirebaseService firebaseService = FirebaseService();
    for (var rsvp in rsvps) {
      await firebaseService.updateRSVP(rsvp);
    }
  }
  // Add a new event
  Future<void> addEvent(Event event) async {
    try {
      // Save the event to Firebase
      await _firebaseService.addEvent(event);
      // Save the event locally in Hive
      await _hiveService.saveEvent(event);
      // Reload events after adding
      await loadEvents();
    } catch (e) {
      print("Error adding event: $e");
    }
  }
}
