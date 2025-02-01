
import 'package:event_rsvp/core/services/firebase_service.dart';
import 'package:event_rsvp/core/services/hive_service.dart';
import 'package:event_rsvp/models/event.dart';
import 'package:event_rsvp/models/rsvp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:event_rsvp/main.dart';

void main() {
  group('RSVP Sync', () {
    test('RSVPs should sync correctly when back online', () async {
      // Prepare mock data for syncing
      final hiveService = HiveService();
      final firebaseService = FirebaseService();

      // Example offline RSVP
      final offlineRSVP = RSVP(eventId: "1",  isAttending: false);
      await hiveService.saveRSVP(offlineRSVP);

      // Simulate syncing
      await hiveService.syncRSVPs([offlineRSVP]);


    });
  });

  group('Conflict Resolution', () {
    test('Conflict should be resolved correctly', () async {
      // Example conflict resolution test
      final event = Event(id: "1", title: "Test Event", date: DateTime.now(),
          attendeeCount: 5);
      final offlineRSVP = RSVP(eventId: event.id, isAttending: false);
      final onlineRSVP = RSVP(eventId: event.id, isAttending:false);

      expect(offlineRSVP,true);
    });
  });
}
