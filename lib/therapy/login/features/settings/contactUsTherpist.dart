import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/features/user/menu/menu_page.dart';
import 'package:mintl555555555/therapy/login/NavigationPagethr.dart';
import 'package:mintl555555555/therapy/login/features/settings/condone.dart';
import 'package:mintl555555555/therapy/login/features/settings/nav2.dart';
import 'package:mintl555555555/therapy/login/features/settings/settings.dart';

class contactUsTherpist extends StatefulWidget {
  const contactUsTherpist({Key? key}) : super(key: key);

  @override
  _contactUsTherpistState createState() => _contactUsTherpistState();
}

class _contactUsTherpistState extends State<contactUsTherpist> {
  TextEditingController contactController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isButtonEnabled = false;
  late User _Therapist;

  @override
  void initState() {
    super.initState();
    _Therapist = FirebaseAuth.instance.currentUser!;
  }

  void _checkButtonStatus() {
    setState(() {
      _isButtonEnabled = contactController.text.isNotEmpty;
    });
  }

  Future<void> _submitContact() async {
    try {
      String? email = _Therapist.email;

      if (email != null) {
        await _firestore.collection('contacts').add({
          'email': email,
          'message': contactController.text,
          'timestamp': DateTime.now(),
          'userId': _Therapist.uid, // Add the user's ID
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ContactUsIsDoneTherpist()),
        );
      } else {
        throw Exception("User is not logged in.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إرسال الرسالة')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: SizeConfig.defaultSize! * 6,
            right: SizeConfig.defaultSize! * 2,
            left: SizeConfig.defaultSize! * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'تواصل معانا',
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
          MaterialPageRoute(builder: (context) => NavigationPagethr2()),
        );
                  },
                  child: Icon(Icons.arrow_forward_ios, size: 20)),
              ],
            ),
          ),
          Positioned(
            top: SizeConfig.defaultSize! * 12,
            bottom: SizeConfig.defaultSize! * 6,
            right: 0,
            left: 0,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    ' يمكنك كتابه مشكلتك هنا سوف نقوم بحلها لك في اقرب وقت ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: TextField(
                    controller: contactController,
                    maxLines: 8,
                    maxLength: 500,
                    textAlign: TextAlign.right,
                    onChanged: (_) {
                      _checkButtonStatus();
                    },
                    decoration: InputDecoration(
                      hintText: 'اكتب ما تريد هنا',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
          Positioned(
            right: SizeConfig.defaultSize! * 2,
            left: SizeConfig.defaultSize! * 2,
            bottom: SizeConfig.defaultSize! * 4,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: _isButtonEnabled ? Color(0xffD68FFF) : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: _isButtonEnabled ? _submitContact : null,
                child: Text(
                  'ارسال ',
                  style: TextStyle(
                      color: _isButtonEnabled ? Color(0xff100D10) : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
