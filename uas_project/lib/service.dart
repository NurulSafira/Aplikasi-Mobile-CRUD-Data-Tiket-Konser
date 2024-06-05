import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:uas_project/event_response.dart';
import 'model.dart';

class EventService {
  final String baseUrl;

  EventService({required this.baseUrl});

  final Dio _dio = Dio();

  Future<List<EventData>> fetchEvents() async {
    try {
      Response response = await _dio.get('$baseUrl/read.php');
      print(response.data);
      if (response.statusCode == 200) {
        return EventResponse.fromJson(response.data).data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }

  Future<void> createEvent(EventData event) async {
    _dio.options
      ..baseUrl = baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.acceptHeader: 'application/json',
      };
    try {
      final response = await _dio.post(
        '/create.php',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'nama': event.name,
          'kategori': event.category,
          'waktu': event.dateTime,
          'tempat': event.venue,
          'deskripsi': event.description,
          'harga': event.price,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        print('Data created successfully: ${response.data}');
      } else {
        throw Exception('Failed to create data: ${response.statusCode}');
      }
    } catch (error) {
      // throw Exception('Failed to create data: $error');
    }
  }

  Future<void> updateEvent(int eventID, EventData event) async {
    _dio.options
      ..baseUrl = baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.acceptHeader: 'application/json',
      };
    try {
      final response = await _dio.post(
        '/update.php',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'id_event': eventID,
          'nama': event.name,
          'kategori': event.category,
          'waktu': event.dateTime,
          'tempat': event.venue,
          'deskripsi': event.description,
          'harga': event.price,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        print('Data updated successfully: ${response.data}');
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update data: $error');
    }
  }

  Future<void> deleteEvent(int eventID) async {
    _dio.options
      ..baseUrl = baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.acceptHeader: 'application/json',
      };
    try {
      print(eventID);

      final response = await _dio.post(
        '/delete.php',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'id_event': eventID,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        print('Data deleted...: ${response.data}');
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete data: $error');
    }
  }

  Future<List<EventData>> searchEvent(String cari) async {
    _dio.options
      ..baseUrl = baseUrl
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        HttpHeaders.acceptHeader: 'application/json',
      };
    try {
      print(cari);

      final response = await _dio.get(
        '/search.php?keyword=$cari',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        print('Data search successfully: ${response.data}');
        return EventResponse.fromJson(response.data).data;
      } else {
        throw Exception('Failed to search data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to search data: $error');
    }
  }
}
