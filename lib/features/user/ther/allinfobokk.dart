import 'package:flutter/material.dart';

class TherapistDetailsPage extends StatefulWidget {
  final String name;
  final String specialty;
  final String? pp; // Profile picture URL

  TherapistDetailsPage({required this.name, required this.specialty, this.pp});

  @override
  _TherapistDetailsPageState createState() => _TherapistDetailsPageState();
}

class _TherapistDetailsPageState extends State<TherapistDetailsPage> {
  bool showAppointments = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name), // Display the therapist's name in the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: widget.pp != null && widget.pp!.isNotEmpty
                    ? NetworkImage(widget.pp!)
                    : AssetImage('assets/images/Therapistimage.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'التخصص: ${widget.specialty}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'التقيم : ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF494649),
                  fontSize: 16,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'البلد : ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 16,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'عدد الجلسات : ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF494649),
                  fontSize: 16,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'مده الجلسه : 2 ساعه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF494649),
                  fontSize: 16,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: buildButtons(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: showAppointments ? buildAppointmentsList() : buildCommentsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showAppointments = false;
              });
            },
            child: buildButtonColumn(
              'التعليقات',
              showAppointments ? Color(0xFFAFA9AE) : Color(0xFFD68FFF),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                showAppointments = true;
              });
            },
            child: buildButtonColumn(
              'المواعيد المتاحه',
              showAppointments ? Color(0xFFD68FFF) : Color(0xFFAFA9AE),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonColumn(String text, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 130,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAppointmentsList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        buildAppointmentCard('السبت', '01', 'ص', '3:00'),
        buildAppointmentCard('الأحد', '02', 'م', '5:00'),
        buildAppointmentCard('الاثنين', '03', 'ص', '9:00'),
      ],
    );
  }

  Widget buildAppointmentCard(String day, String date, String period, String time) {
    return Container(
      width: 72,
      height: 88,
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE8E0E5)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF494649),
              fontSize: 14,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w500,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF100D10),
              fontSize: 16,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF494649),
                    fontSize: 14,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF494649),
                    fontSize: 14,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentsList() {
    return ListView(
      children: [
        buildCommentCard('Comment 1'),
        buildCommentCard('Comment 2'),
        buildCommentCard('Comment 3'),
      ],
    );
  }

  Widget buildCommentCard(String comment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Text(comment),
      ),
    );
  }
}
