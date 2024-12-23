class EventTime {
  DateTime? start;
  DateTime? end;

  EventTime({this.start, this.end});

  factory EventTime.fromJson(Map<String, dynamic> json) {
    return EventTime(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start?.toIso8601String(),
      'end': end?.toIso8601String(),
    };
  }
}
