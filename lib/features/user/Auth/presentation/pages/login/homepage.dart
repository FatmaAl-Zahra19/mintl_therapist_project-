import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/Chatbutton.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/complete_information/complete_information_view.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/CustomHomeAppbar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late String currentUserEmail = '';
  late String aiPic = '';

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail();
  }

  void getCurrentUserEmail() {
    final currentUser = FirebaseAuth.instance.currentUser;
    currentUserEmail = currentUser!.email!; // Get current user's email
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            CustomHomeAppBar(),
            Positioned(
              right: SizeConfig.defaultSize! * 2,
              left: SizeConfig.defaultSize! * 2,
              bottom: SizeConfig.defaultSize! * 4,
              child: InkWell(
                onTap: () {
                  
                },
                child: Chatbutton(),
              ),
            ),
            Positioned(
              right: SizeConfig.defaultSize! * 2,
              left: SizeConfig.defaultSize! * 2,
              top: SizeConfig.defaultSize! * 10,
              bottom: SizeConfig.defaultSize! * 10,
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('AI_CHAR')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      var docs = snapshot.data!.docs;
                      var aiPicDoc = docs.firstWhere(
                        (doc) => doc['ai_email'] == currentUserEmail,
                        
                      );
                      if (aiPicDoc != null) {
                        aiPic = aiPicDoc['Ai_pic'];
                        return Image.asset(
                          aiPic,
                          width: MediaQuery.of(context).size.width,
                        );
                      } else {
                        return Text('No AI pic found');
                      }
                    } else {
                      return Text('No data found');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
 );
  }
}
