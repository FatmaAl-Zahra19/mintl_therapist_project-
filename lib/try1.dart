import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mintl555555555/features/meet/meeting_screen.dart';

class AddSessionButton extends StatefulWidget {
  final String meetingId;

  const AddSessionButton({ Key? key, required this.meetingId}) : super(key: key);

  @override
  _AddSessionButtonState createState() => _AddSessionButtonState();
}

class _AddSessionButtonState extends State<AddSessionButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _addSessionToFirestore(widget.meetingId);
      },
      child: Text('Add Session'),
    );
  }

  Future<void> _addSessionToFirestore(String meetingID) async {
    try {
      // Replace 'your_collection_name' with 'sessioncollection'
      final CollectionReference sessions =
          FirebaseFirestore.instance.collection('sessioncollection');

      // Replace these with the actual values you want to add
      await sessions.add({
        'session_date': DateTime.now(),
        'session_duration': 60, // for example
        'therapist_name': 'John Doe',
        'therapist_specialist': 'Psychologist',
        'session_hour': '10:00 AM',
        'therapist_photo': 'url_to_photo',
        'meetingID': meetingID, // Pass meetingID here
        'compareDatacompareData': 'compare_data',
        'compareHour': 'compare_hour',
        'user_email': 'mh722851@gmail.com',
        'user_name': 'John Doe',
        'theraist_email': 'ma6597774@gmail.com',
      });
      print('Session added successfully');
    } catch (e) {
      print('Error adding session: $e');
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Session'),
        ),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _meetingIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _meetingIdController,
          decoration: InputDecoration(
            hintText: 'Enter meeting ID',
          ),
        ),
        SizedBox(height: 20),
        AddSessionButton(meetingId: _meetingIdController.text),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}
