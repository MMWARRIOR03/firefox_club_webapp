import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id;
  String title;
  String description;
  DateTime dateTime;
  String location;
  int capacity;
  int attendeesCount;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.capacity,
    required this.attendeesCount,
  });

  // Convert a Firestore document to an Event object
  factory Event.fromFirestore(Map<String, dynamic> firestoreData) {
    return Event(
      id: firestoreData['id'],
      title: firestoreData['title'],
      description: firestoreData['description'],
      dateTime: (firestoreData['dateTime'] as Timestamp).toDate(),
      location: firestoreData['location'],
      capacity: firestoreData['capacity'],
      attendeesCount: firestoreData['attendeesCount'],
    );
  }

  // Convert Event object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'location': location,
      'capacity': capacity,
      'attendeesCount': attendeesCount,
    };
  }
}
