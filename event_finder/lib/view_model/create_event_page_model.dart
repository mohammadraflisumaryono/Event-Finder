class CreateEventModel {
  String title;
  String description;
  double ticketPrice;
  DateTime startTime;
  DateTime endTime;

  CreateEventModel({
    required this.title,
    required this.description,
    required this.ticketPrice,
    required this.startTime,
    required this.endTime,
  });
}
