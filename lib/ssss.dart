import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Therapist {
  final String id; // Document ID
  final String name;
  final String specialty;
  final String? pp; // Profile picture URL
  final String? country;
  final int? moda;
  final int? price;

  Therapist({
    required this.id,
    required this.name,
    required this.specialty,
    this.pp,
    this.country,
    this.moda,
    this.price,
  });

  factory Therapist.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Therapist(
      id: doc.id,
      name: data['name'] ?? '',
      specialty: data['specialty'] ?? '',
      pp: data['pp'],
      country: data['country'],
      moda: data['moda'],
      price: data['price'],
    );
  }
}

class TherapistsListPage111 extends StatefulWidget {
  @override
  _TherapistsListPage111State createState() => _TherapistsListPage111State();
}

class _TherapistsListPage111State extends State<TherapistsListPage111> {
  late Future<List<Therapist>> therapistsFuture;
  File? _imageFile; // Variable to store the selected image file
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    therapistsFuture = fetchTherapistsFromFirestore();
  }

  Future<List<Therapist>> fetchTherapistsFromFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Therapist_Information')
        .get();

    List<Therapist> therapists = querySnapshot.docs.map((doc) {
      return Therapist.fromFirestore(doc);
    }).toList();

    return therapists;
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await _picker.pickImage(source: source);
    if (selected != null) {
      setState(() {
        _imageFile = File(selected.path);
      });
      // Upload the selected image to Firebase Storage and update Firestore
      await uploadImageToStorageAndFirestore(selected.path);
    }
  }

  Future<void> uploadImageToStorageAndFirestore(String filePath) async {
    try {
      // Generate a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(fileName);

      // Upload the image to Firebase Storage
      TaskSnapshot storageTaskSnapshot = await storageReference.putFile(File(filePath));
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Update the profile picture URL in Firestore
      await FirebaseFirestore.instance
          .collection('Therapist_Information')
          .doc('some_document_id') // Replace with actual document ID
          .update({
        'pp': downloadUrl,
      });

      // Refresh the UI
      setState(() {});
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Therapist>>(
      future: therapistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          Therapist firstTherapist = snapshot.data!.first;
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pickImage(ImageSource.gallery); // Open gallery when tapped
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : firstTherapist.pp != null && firstTherapist.pp!.isNotEmpty
                                        ? NetworkImage(firstTherapist.pp!) as ImageProvider
                                        : AssetImage('assets/images/Therapistimage.png') as ImageProvider,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () => _pickImage(ImageSource.gallery),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ' ${firstTherapist.name} :الاسم ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'التخصص: ${firstTherapist.specialty}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '  :التقييم ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ' البلد : ${firstTherapist.country}  ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '  :عدد الجلسات ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                   Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xffD68FFF)),
                          onPressed: () {
                            
                          },
                        ),
                                        const Spacer(),

                                RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: ':مدة الجلسة التي تريدها  ',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '',
                                style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff494649),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                        Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xffD68FFF)),
                          onPressed: () {
                            
                          },
                        ),
                                        const Spacer(),

                                RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: ':سعر الجلسة ',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '',
                                style: const TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff494649),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
