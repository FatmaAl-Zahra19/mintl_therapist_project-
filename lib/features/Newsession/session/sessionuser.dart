import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; 
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/features/meet/api_call.dart';
import 'package:mintl555555555/features/meet/meeting_screen.dart';
import 'package:mintl555555555/features/user/menu/menu_page.dart';

class SessionUser extends StatefulWidget {
  const SessionUser({Key? key}) : super(key: key);

  @override
  State<SessionUser> createState() => _SessionUserState();
}

class _SessionUserState extends State<SessionUser> {
  final TextEditingController _meetingIdController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Text(
            '  جلساتي',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF100D10),
              fontSize: 24,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Icon(Icons.arrow_forward_ios, size: 20),
          ),
          SizedBox(width: 16),
        ],
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
                        .where("user_email", isEqualTo: currentUser?.email)
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
          'assets/images/emptySession.png',
          width: MediaQuery.of(context).size.width * .95,
        ),
        SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), 
          child: CustomGeneralButton(
            onTap: (){
              // Add your onTap code here
            },
            text: " اختار معالجك الان",
          ),
        ),
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
      return SizedBox.shrink(); // Skip rendering this session if any critical field is missing
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
      isFutureSession,
      isEnableButton,
      onPressed: () {
        onCreateButtonPressed(context, doc);
      },
      doc: doc,
    );
  }
void onCreateButtonPressed(BuildContext context, QueryDocumentSnapshot doc) async {
    // call api to create meeting and navigate to MeetingScreen with meetingId,token
    try {
            final String meetingId = await createMeeting();
      
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('sessioncollection').doc(doc.id).update({'meetingId': meetingId});
      
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token, // Replace 'token' with your actual token
          ),
        ),
      );
    } catch (e) {
      print('Error creating meeting: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create meeting. Please try again later."),
        ),
      );
    }
  }
  void onJoinButtonPressed(BuildContext context, String meetingId) {
    var re = RegExp("\\w{4}-\\w{4}-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: 'token', // Replace 'token' with your actual token
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
  String meetingId,
  bool isFutureSession,
  bool isEnableButton, {
  VoidCallback? onPressed,
  required QueryDocumentSnapshot doc,
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
                therapistName,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF100D10),
                  fontSize: 18,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                therapistSpecialist,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF494649),
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
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
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: therapistPhoto.isNotEmpty
                  ? NetworkImage(therapistPhoto)
                  : AssetImage('assets/images/onbording_bak.png') as ImageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
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

