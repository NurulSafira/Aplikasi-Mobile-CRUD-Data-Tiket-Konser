import 'package:flutter/material.dart';
import 'model.dart';

class DetailEventPage extends StatelessWidget {
  final EventData event;

  const DetailEventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Kategori: ${event.category}'),
            Text('Waktu: ${event.dateTime}'),
            Text('Tempat: ${event.venue}'),
            Text('Harga: \$${event.price}'),
            // Text('Harga: \$${event.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
