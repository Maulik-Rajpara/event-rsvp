class RSVP {
  final String eventId;
  final bool isAttending;

  RSVP({required this.eventId, required this.isAttending});

  factory RSVP.fromMap(Map<String, dynamic> map) {
    return RSVP(
      eventId: map['eventId'],
      isAttending: map['isAttending'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'isAttending': isAttending,
    };
  }
}
