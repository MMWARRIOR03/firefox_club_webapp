import 'package:flutter/material.dart';
import 'package:firefox_club_webapp/models/event.dart';
import 'package:firefox_club_webapp/services/event_service.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Location: ${event.location}', style: TextStyle(fontSize: 14)),
            Text('Date & Time: ${event.dateTime}',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            Text('Razorpay api to be added here'),
            ElevatedButton(
              onPressed: () {
                EventService().registerForEvent(event.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Registered for ${event.title}!'),
                ));
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
