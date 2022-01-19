class EventModel {
  String category;
  String title;
  String startDate;
  String endDate;
  String location;
  String startTimeHr;
  String startTimeMin;
  String duration;
  String recurrence;

  EventModel(
      {required this.category,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.startTimeHr,
      required this.startTimeMin,
      required this.duration,
      required this.recurrence});

  factory EventModel.fromJson(dynamic json) {
    return EventModel(
      category: "${json['category']}",
      title: "${json['title']}",
      startDate: "${json['startDate']}",
      endDate: "${json['endDate']}",
      location: "${json['location']}",
      startTimeHr: "${json['startTimeHr']}",
      startTimeMin: "${json['startTimeMin']}",
      duration: "${json['duration']}",
      recurrence: "${json['recurrence']}",
    );
  }

  Map toJson() => {
        "category": category,
        "title": title,
        "startDate": startDate,
        "endDate": endDate,
        "location": location,
        "startTimeHr": startTimeHr,
        "startTimeMin": startTimeMin,
        "duration": duration,
        "recurrence": recurrence
      };
}
