import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class EventService {
  final String baseUrl;

  EventService({required this.baseUrl});

  Future<List<EventData>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/read.php'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body)['data'];
      return data.map((event) => EventData.fromJson(event)).toList();
    } else {
      throw Exception('Failed to fetch events');
    }
  }

  Future<void> createEvent(EventData event) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      body: json.encode({
        'name': event.name,
        'category': event.category,
        'venue': event.venue,
        'price': event.price,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create event');
    }
  }

  Future<List<EventData>> searchEvents(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?keyword=$keyword'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body)['data'];
      return data.map((event) => EventData.fromJson(event)).toList();
    } else {
      throw Exception('Failed to search events');
    }
  }
}
