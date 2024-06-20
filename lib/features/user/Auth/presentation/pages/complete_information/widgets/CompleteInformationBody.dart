import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mintl555555555/core/constants.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/complete_information/widgets/AiInfo.dart';

class CompleteInformationBody extends StatefulWidget {
  const CompleteInformationBody({Key? key}) : super(key: key);

  @override
  _CompleteInformationBodyState createState() =>
      _CompleteInformationBodyState();
}

class _CompleteInformationBodyState extends State<CompleteInformationBody> {
  String gender = ''; // Variable to store the selected gender
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  bool isNameFieldFocused = false;
  bool isDateFieldFocused = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _saveUserInfo() async {
    String name = nameController.text;

    if (name.isNotEmpty && selectedDate != null && gender.isNotEmpty) {
      String? email = _auth.currentUser?.email;

      if (email != null) {
        await FirebaseFirestore.instance.collection('user_info').add({
          'الاسم': name,
          'تاريخ الميلاد': DateFormat('dd/MM/yyyy').format(selectedDate!),
          'النوع': gender,
          'Email': email,
        }).then((value) {
          // Document added successfully
          print('User info added successfully');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AiInfo(), // Replace with your home page
            ),
          );
        }).catchError((error) {
          // Error occurred while adding document
          print('Failed to add user info: $error');
        });
      } else {
        print('User email not found');
      }
    } else {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('أكمل جميع البيانات'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('تم'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children:[ Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 64,),
               Center(
                 child: Text(
                             '  معلوماتك',
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
                           SizedBox(height: 24,),
        
              Text(
                ' الاسم',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: nameController,
                textAlign: TextAlign.right,
                // textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'ادخل اسمك',
                  prefixIcon: Icon(Icons.person,
                      color: isNameFieldFocused ? kMainColor : null),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isNameFieldFocused ? kMainColor : Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isNameFieldFocused ? kMainColor : Colors.black),
                  ),
                ),
                onTap: () {
                  setState(() {
                    isNameFieldFocused = true;
                    isDateFieldFocused = false;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    isNameFieldFocused = false;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                ' تاريخ الميلاد',
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextField(
                    textAlign: TextAlign.right,
                    // textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'اختر تاريخ الميلاد',
                      prefixIcon: Icon(Icons.calendar_today,
                          color: isDateFieldFocused ? kMainColor : null),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kMainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                isDateFieldFocused ? kMainColor : Colors.black),
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'النوع',
                style: TextStyle(color: Colors.black),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('ذكر'),
                      Radio<String>(
                        value: 'ذكر',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('انثى'),
                      Radio<String>(
                        value: 'انثى',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
        ),
        Positioned(
             left: SizeConfig.defaultSize! * 2,
              right: SizeConfig.defaultSize! * 2,
              bottom: SizeConfig.defaultSize! * 6,
          child: CustomGeneralButton(
                  onTap: _saveUserInfo,
                  text: "حفظ",
                ),
        ),
     ] ),
    );
  }
}
