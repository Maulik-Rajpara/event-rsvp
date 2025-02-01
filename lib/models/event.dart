class Event {
  final String id;
  final String title;
  final DateTime date;
  late final int attendeeCount;

  Event({required this.id, required this.title, required this.date, required this.attendeeCount});

  // Generate a unique ID based on the current time
  Event.withUniqueId({required this.title, required this.date,
    required this.attendeeCount})
      : id = DateTime.now().millisecondsSinceEpoch.toString();

  // Convert the Event object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'attendeeCount': attendeeCount,
    };
  }

  // Convert a Map<String, dynamic> into an Event object
  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      attendeeCount: map['attendeeCount'],
    );
  }
}
