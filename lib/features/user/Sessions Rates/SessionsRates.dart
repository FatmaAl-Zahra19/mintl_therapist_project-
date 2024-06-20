// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mintl555555555/core/utils/size_config.dart';
// import 'package:mintl555555555/features/user/Sessions%20Rates/rate_correctly_send.dart';

// class RatingPage extends StatefulWidget {
//   const RatingPage({super.key});

//   @override
//   _RatingPageState createState() => _RatingPageState();
// }

// class _RatingPageState extends State<RatingPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   double rating = 0.0;
//   TextEditingController commentController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool _isButtonEnabled = false;
//   late User _user;
//   String therapistEmail = '';
//   late DocumentSnapshot sessionDoc;

//   @override
//   void initState() {
//     super.initState();
//     _user = _auth.currentUser!;
//     _fetchSessionDoc();
//   }

//   Future<void> _fetchSessionDoc() async {
//     try {
//       // Assuming you have the session ID from somewhere, replace 'your_session_id' with the actual session ID.
//       String sessionId = 'your_session_id'; // Update this with your actual session ID logic.
//       sessionDoc = await _firestore.collection("sessioncollection").doc(sessionId).get();
//       if (sessionDoc.exists) {
//         therapistEmail = sessionDoc['therapist_email'];
//         setState(() {});
//       } else {
//         print('Session document does not exist');
//       }
//     } catch (e) {
//       print('Error fetching session document: $e');
//     }
//   }

//   void _checkButtonStatus() {
//     setState(() {
//       _isButtonEnabled = rating > 0 && commentController.text.isNotEmpty;
//     });
//   }

//   Future<void> _submitRating() async {
//     try {
//       String? email = _user.email;
//       if (email != null && therapistEmail.isNotEmpty) {
//         await _firestore.collection('ratings').add({
//           'rating': rating,
//           'comment': commentController.text,
//           'timestamp': DateTime.now(),
//           'useremail': email,
//           'therapistemail': therapistEmail,
//         });
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => RateCorrectlySend()), // Navigate to the Nav page
//         );
//       } else {
//         print('User email or therapist email is missing');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('حدث خطأ أثناء إرسال التقييم')),
//       );
//       print('Error submitting rating: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             top: SizeConfig.defaultSize! * 6,
//             right: SizeConfig.defaultSize! * 2,
//             left: SizeConfig.defaultSize! * 2,
//             child: Text(
//               'تقييم',
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 color: Color(0xFF100D10),
//                 fontSize: 24,
//                 fontFamily: 'Tajawal',
//                 fontWeight: FontWeight.bold,
//                 height: 1.5,
//               ),
//             ),
//           ),
//           Positioned(
//             top: SizeConfig.defaultSize! * 12,
//             bottom: SizeConfig.defaultSize! * 6,
//             right: 0,
//             left: 0,
//             child: ListView(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'تقييم المعالج',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: RatingBar.builder(
//                     initialRating: rating,
//                     minRating: 0,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemSize: SizeConfig.defaultSize! * 6,
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star_rounded,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (newRating) {
//                       setState(() {
//                         rating = newRating;
//                         _checkButtonStatus();
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'تعليقك على الجلسه بشكل عام',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextField(
//                     controller: commentController,
//                     maxLines: 8,
//                     maxLength: 500,
//                     textAlign: TextAlign.right,
//                     onChanged: (_) {
//                       _checkButtonStatus();
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'اكتب ما تريد هنا',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32),
//               ],
//             ),
//           ),
//           Positioned(
//             right: SizeConfig.defaultSize! * 2,
//             left: SizeConfig.defaultSize! * 2,
//             bottom: SizeConfig.defaultSize! * 4,
//             child: Container(
//               height: 52,
//               decoration: BoxDecoration(
//                 color: _isButtonEnabled ? Color(0xffD68FFF) : Colors.grey,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextButton(
//                 onPressed: _isButtonEnabled ? _submitRating : null,
//                 child: Text(
//                   'ارسال ',
//                   style: TextStyle(
//                       color: _isButtonEnabled ? Color(0xff100D10) : Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/features/user/Sessions%20Rates/rate_correctly_send.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rating = 0.0;
  TextEditingController commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isButtonEnabled = false;
  late User _user;

  @override
  void initState() {
    super.initState();
    // Initialize user here
    _user = FirebaseAuth.instance.currentUser!;
    _checkButtonStatus();
  }

  void _checkButtonStatus() {
    setState(() {
      _isButtonEnabled = rating > 0 && commentController.text.isNotEmpty;
    });
  }

  Future<void> _submitRating() async {
    try {
      String? email = _user.email;
      if (email != null) {
        await _firestore.collection('ratings').add({
          'rating': rating,
          'comment': commentController.text,
          'timestamp': DateTime.now(),
          'userId': _user.uid,
          'useremail': _user.email, 
          
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RateCorrectlySend()), // Navigate to RateCorrectlySend page
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إرسال التقييم')),
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
            child: Text(
              'تقييم',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 24,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.defaultSize! * 12, // Adjust the top position
            bottom: SizeConfig.defaultSize! * 6,
            right: 0,
            left: 0,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تقييم المعالج',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: SizeConfig.defaultSize! * 6,
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        rating = newRating;
                        _checkButtonStatus();
                      });
                    },
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تعليقك على الجلسه بشكل عام',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextField(
                    controller: commentController,
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
                onPressed: _isButtonEnabled ? _submitRating : null,
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
