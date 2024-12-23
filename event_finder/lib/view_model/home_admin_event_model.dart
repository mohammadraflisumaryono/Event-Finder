class Event {
  final int id;
  final String title;
  final String description;
  final double ticketPrice;
  final DateTime startTime;
  final DateTime endTime;
  final bool isApproved;
  final String createdBy;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.ticketPrice,
    required this.startTime,
    required this.endTime,
    required this.isApproved,
    required this.createdBy,
  });
}
