import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firefox_club_webapp/models/event.dart';
import 'package:firefox_club_webapp/services/google_sign_in_service.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String username = GoogleSignInService().getUserName();
  final String usermail = GoogleSignInService().getUserEmail();

  Future<List<Event>> getAllEvents() async {
    final snapshot = await _db.collection('events').get();
    return snapshot.docs.map((doc) => Event.fromFirestore(doc.data())).toList();
  }

  Future<void> createEvent(Event event) async {
    try {
      await _db.collection('events').add(event.toFirestore());
    } catch (e) {
      print('Error creating event: $e');
    }
  }

  Future<void> registerForEvent(String eventId) async {
    String usrnamemail = "$username - $usermail";
    try {
      final eventDoc = _db.collection('events').doc(eventId);
      await eventDoc.update({
        'attendeesCount': FieldValue.increment(1),
        'attendees': FieldValue.arrayUnion([usrnamemail]),
      });
    } catch (e) {
      print('Error registering for event: $e');
    }
  }
}
