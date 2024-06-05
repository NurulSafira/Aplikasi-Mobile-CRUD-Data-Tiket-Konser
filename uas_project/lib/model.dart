// model.dart
class EventData {
  final int idEvent;
  final String name;
  final String category;
  final String dateTime;
  final String venue;
  final String description; // Menambahkan deskripsi
  final int price;

  EventData({
    required this.idEvent,
    required this.name,
    required this.category,
    required this.dateTime,
    required this.venue,
    required this.description, // Menambahkan deskripsi
    required this.price,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      idEvent: int.parse(json['id_event']),
      name: json['nama'],
      category: json['kategori'],
      dateTime: json['waktu'],
      venue: json['tempat'],
      description: json['deskripsi'], // Mengambil deskripsi
      price: int.parse(json['harga']),
    );
  }
}
