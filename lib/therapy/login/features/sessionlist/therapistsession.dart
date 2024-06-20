import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/features/meet/meeting_screen.dart';
import 'dart:io';

class SessionTherapist extends StatefulWidget {
  const SessionTherapist({Key? key}) : super(key: key);

  @override
  State<SessionTherapist> createState() => _SessionTherapistState();
}

class _SessionTherapistState extends State<SessionTherapist> {
  final TextEditingController _meetingIdController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.defaultSize! * 4),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("sessioncollection")
                        .where("theraist_email", isEqualTo: currentUser?.email)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return _buildEmptyState(context);
                      } else {
                        List<QueryDocumentSnapshot> currentSessions = [];
                        List<QueryDocumentSnapshot> upcomingSessions = [];
                        List<QueryDocumentSnapshot> previousSessions = [];

                        for (var doc in snapshot.data!.docs) {
                          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                          DateTime? sessionDate = data['session_date'] != null ? (data['session_date'] as Timestamp).toDate() : null;
                          String? sessionDuration = data['session_duration']?.toString();

                          if (sessionDate != null && sessionDuration != null) {
                            DateTime sessionEnd = sessionDate.add(Duration(minutes: int.parse(sessionDuration)));

                            if (sessionDate.isBefore(now) && sessionEnd.isAfter(now)) {
                              currentSessions.add(doc);
                            } else if (sessionDate.isAfter(now)) {
                              upcomingSessions.add(doc);
                            } else {
                              previousSessions.add(doc);
                            }
                          }
                        }

                        return ListView(
                          children: [
                            _buildSection(context, "جلسات الان", currentSessions, now),
                            SizedBox(height: 16),
                            _buildSection(context, "الجلسات القادمة", upcomingSessions, now),
                            SizedBox(height: 16),
                            _buildSection(context, "الجلسات السابقة", previousSessions, now),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/emptytherpiatlist.png',
          width: MediaQuery.of(context).size.width * .95,
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<QueryDocumentSnapshot> sessions,
    DateTime now,
  ) {
    if (sessions.isEmpty) {
      return SizedBox.shrink();
    }

    bool isTodaySection = title == "جلسات الان";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF100D10),
              fontSize: 20,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
        ),
        ...sessions.map((doc) => _buildSessionCard(doc, isTodaySection, now)).toList(),
      ],
    );
  }

  Widget _buildSessionCard(QueryDocumentSnapshot doc, bool isTodaySection, DateTime now) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    DateTime? sessionDate = data['session_date'] != null ? (data['session_date'] as Timestamp).toDate() : null;
    String? sessionDuration = data['session_duration']?.toString();
    String? meetingID = data['meetingID']?.toString();
    String therapistName = data['therapist_name']?.toString() ?? '';
    String therapistSpecialist = data['therapist_specialist']?.toString() ?? '';
    String therapistPhoto = data['therapist_photo']?.toString() ?? '';
    String userName = data['user_name']?.toString() ?? '';

    if (sessionDate == null || sessionDuration == null || meetingID == null) {
      return SizedBox.shrink();
    }

    DateTime sessionEnd = sessionDate.add(Duration(minutes: int.parse(sessionDuration)));

    bool isFutureSession = sessionDate.isAfter(now) || sessionEnd.isAfter(now);

    bool isEnableButton = isTodaySection &&
        sessionDate.day == now.day &&
        sessionDate.month == now.month &&
        sessionDate.year == now.year &&
        now.isAfter(sessionDate) && now.isBefore(sessionEnd);

    return sessionCard(
      therapistName,
      therapistSpecialist,
      sessionDuration,
      sessionDate,
      therapistPhoto,
      meetingID,
      userName,
      isFutureSession,
      isEnableButton,
      onPressed: () {
        onJoinButtonPressed(context, meetingID);
      },
      doc: doc,
    );
  }

  void onJoinButtonPressed(BuildContext context, String meetingId) {
    var re = RegExp("\\w{4}-\\w{4}-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: 'token',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter a valid meeting id"),
      ));
    }
  }
}

Widget sessionCard(
  String therapistName,
  String therapistSpecialist,
  String sessionDuration,
  DateTime sessionDate,
  String therapistPhoto,
  String meetingID,
  String userName,
  bool isFutureSession,
  bool isEnableButton, {
  required QueryDocumentSnapshot doc,
  VoidCallback? onPressed,
}) {
  String formattedDate = DateFormat.yMMMMd().format(sessionDate);
  String formattedHour = DateFormat.jm().format(sessionDate);

  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x33D68FFF),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                userName,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF100D10),
                  fontSize: 18,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildInfo(sessionDuration),
                  Image.asset(
                    'assets/images/hourglass.png',
                    width: 16,
                    height: 16,
                  ),
                  _buildInfo(formattedHour),
                  Image.asset(
                    'assets/images/clock.png',
                    width: 16,
                    height: 16,
                  ),
                  _buildInfo(formattedDate),
                  Image.asset(
                    'assets/images/calendars.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DeleteIcon(doc: doc),
                  SizedBox(width: 32,),
                  if (!isFutureSession)
                    UploadWidget(doc: doc),
                  SizedBox(width: 16,),
                  if (isFutureSession)
                    ElevatedButton(
                      onPressed: isEnableButton ? onPressed : null,
                      child: Text('انضمام'),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    ),
  );
}

Widget _buildInfo(String text) {
  return Container(
    margin: EdgeInsets.only(left: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 4),
        Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF494649),
            fontSize: 12,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class DeleteIcon extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  DeleteIcon({required this.doc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection("sessioncollection")
            .doc(doc.id)
            .delete();
      },
      child: Icon(
        Icons.delete,
        color: Colors.black,
        size: 24,
      ),
    );
  }
}

class UploadWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final QueryDocumentSnapshot doc;

  UploadWidget({required this.doc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openFilePicker(context);
      },
      child: Icon(Icons.file_upload), // You can use any icon or custom widget here
    );
  }

  void _openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          // Upload the file to Firebase Storage
          await _uploadFile(context, filePath);
        }
      } else {
        print("User canceled the picker");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> _uploadFile(BuildContext context, String filePath) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user is signed in")),
      );
      return;
    }

    String fileName = filePath.split('/').last;
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploads/$fileName');

    UploadTask uploadTask = storageReference.putFile(File(filePath));

    try {
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Fetch user_email from sessioncollection document
      DocumentSnapshot sessionDoc = await FirebaseFirestore.instance
          .collection("sessioncollection")
          .doc(doc.id)
          .get();

      String userEmail = sessionDoc['user_email'];

      // Store the file URL in Firestore
      await FirebaseFirestore.instance.collection('Rusta').add({
        'email': currentUser.email,
        'file_url': downloadURL,
        'uploaded_at': Timestamp.now(),
        'user_email': userEmail,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File uploaded successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading file: $e")),
      );
    }
  }
}
