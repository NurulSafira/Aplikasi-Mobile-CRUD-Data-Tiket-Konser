import './model.dart';

class EventResponse {
  late List<EventData> data;

  EventResponse({required this.data});

  factory EventResponse.fromJson(List<dynamic> json) {
    return EventResponse(
      data: json.map((e) => EventData.fromJson(e)).toList(),
    );
  }
}
