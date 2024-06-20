import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/complete_information/widgets/CompleteInformationBody.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/homepage.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/nav.dart';

class AiInfo extends StatefulWidget {
  const AiInfo({super.key});

  @override
  State<AiInfo> createState() => _AiInfoState();
}

final List<String> imageUrls = [
  // Add your image URLs here
  'assets/images/cha1.png',
  'assets/images/cha2.png',
  'assets/images/cha3.png',
  'assets/images/cha4.png',
  'assets/images/cha5.png',
  'assets/images/cha6.png',
  'assets/images/cha7.png',
  'assets/images/cha8.png',
  'assets/images/cha9.png',
  'assets/images/cha10.png',
  'assets/images/cha11.png',
  'assets/images/cha12.png',
  'assets/images/cha13.png',
  'assets/images/cha14.png',
  'assets/images/cha15.png',
  'assets/images/cha16.png',
  'assets/images/cha17.png',
  'assets/images/cha18.png',
  'assets/images/cha19.png',
  'assets/images/cha20.png',
  'assets/images/cha21.png',
  'assets/images/cha22.png',
  'assets/images/cha23.png',
  'assets/images/cha24.png',
];

class _AiInfoState extends State<AiInfo> {
  int selectedImageIndex = -1;
  String friendName = '';

  void addUserDataToFirestore() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userEmail = user?.email;

    if (selectedImageIndex != -1 && friendName.isNotEmpty && userEmail != null) {
      String aiPic = imageUrls[selectedImageIndex];
      FirebaseFirestore.instance.collection('AI_CHAR').add({
        'char name': friendName,
        'Ai_pic': aiPic,
        'ai_email': userEmail, // Add the new field here
      }).then((value) {
        // Data added successfully
        print('User data added to Firestore');
      }).catchError((error) {
        // Error handling
        print('Failed to add user data: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(''),
        ),
        actions: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 90, top: 15),
                child: Text(
                  'اختار صديقك',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  addUserDataToFirestore();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext) {
                        return CompleteInformationBody();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 270),
                    child: const Text(
                      'اسم صديقك',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                    child: TextField(
                      scrollPadding: EdgeInsets.all(8),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'Tajawal', fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          // borderSide: BorderSide(
                          //   color: friendName.isNotEmpty
                          //       ? Color.fromARGB(255, 214, 143, 255)
                          //       : Color(0xFFAFA9AE),
                          // ),
                        ),
                        hintText: 'Mohammed',
                        hintTextDirection: TextDirection.rtl,
                        contentPadding: EdgeInsets.only(left: 290, right: 16),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: friendName.isNotEmpty
                              ? Color.fromARGB(255, 214, 143, 255)
                              : Color(0xffAFA9AE),
                        ),
                        fillColor: friendName.isNotEmpty
                            ? Color.fromARGB(255, 214, 143, 255)
                            : Color(0xffAFA9AE),
                        constraints: BoxConstraints(
                          maxHeight: 40,
                          minWidth: 25,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Color.fromARGB(255, 214, 143, 255)
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          friendName = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 280),
                    child: const Text(
                      'الشخصيه',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 565,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF5BDFE),
                                    Color(0xFFE6BDFE),
                                    Color(0xFF55D4FF),
                                  ],
                                  stops: [
                                    0.12,
                                    0.7,
                                    1,
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                ),
                                border: Border.all(
                                  color: selectedImageIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Transform.scale(
                                scale: selectedImageIndex == index ? 0.8 : 1.0,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    imageUrls[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10,left:10),
                    child: CustomGeneralButton(
                                  text: 'حفظ',
                                  onTap: () {
                    addUserDataToFirestore();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) {
                          return NavigationPage();
                        },
                      ),
                    );
                                    },
                                 ),
                  ),
                  SizedBox(height: 24,)
                ],
              ),
            
            ],
          ),
      ),
      
      
    );
  }
}

