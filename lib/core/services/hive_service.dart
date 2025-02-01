import 'package:hive/hive.dart';


import '../../models/event.dart';
import '../../models/rsvp.dart';
import 'firebase_service.dart';

class HiveService {
  final Box _eventBox = Hive.box('events');
  final Box _rsvpBox = Hive.box('rsvps');

  Future<void> saveEvent(Event event) async {
    await _eventBox.put(event.id, event.toMap());
  }

  List<Event> getEvents() {
    List<Event> events = [];
    for (var e in _eventBox.values) {
      // Check and print the type of each stored value for debugging
      print('Stored data: $e');
      print('Data type: ${e.runtimeType}');

      // Ensure that the value is a Map<String, dynamic> before converting to Event
      if (e is Map<String, dynamic>) {
        try {
          // Try parsing the event from the map
          events.add(Event.fromMap(e));
        } catch (error) {
          // Handle cases where data can't be parsed into an Event
          print('Error parsing event: $error');
        }
      } else {
        print('Invalid data format: Expected Map<String, dynamic>, but got ${e.runtimeType}');
      }
    }
    return events;

  }

  Future<void> syncRSVPs(List<RSVP> rsvps) async {
    final FirebaseService firebaseService = FirebaseService();
    for (var rsvp in rsvps) {
      await firebaseService.updateRSVP(rsvp);
    }
  }

  Future<void> saveRSVP(RSVP rsvp) async {
    await _rsvpBox.put(rsvp.eventId, rsvp.toMap());
  }

  List<RSVP> getRSVPs() {
    return _rsvpBox.values.map((e) => RSVP.fromMap(e)).toList();
  }
}
