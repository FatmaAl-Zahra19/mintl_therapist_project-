import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/therapy/login/NavigationPagethr.dart';

class TherapistInformationPage extends StatefulWidget {
  const TherapistInformationPage({Key? key}) : super(key: key);

  @override
  _TherapistInformationPageState createState() => _TherapistInformationPageState();
}

class _TherapistInformationPageState extends State<TherapistInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  late String _name = '';
  late String _specialty = '';
  late String _country = '';
  late int _price = 0;
  late int _moda=0;
  String _gender = '';
  File? _card;
  File? _unionCard;
  File? _graduationCertificate;
  File? _cv;
    File? _pp;

  File? _imageWithCard;
  bool _isSubmitting = false;
  bool _isPickingFile = false; // Flag to control file picker

  Future<String?> uploadFile(File? file) async {
    if (file == null) return null;

    try {
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('files/${DateTime.now().millisecondsSinceEpoch}')
          .putFile(file);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<File?> _getFile() async {
    if (_isPickingFile) return null;
    setState(() {
      _isPickingFile = true; // Set flag to true when picking file
    });

    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return null;
      return File(result.files.single.path!);
    } finally {
      setState(() {
        _isPickingFile = false; // Reset flag after picking file
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معلوماتك'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildTextField('الاسم', (value) => _name = value!),
            _buildTextField('التخصص', (value) => _specialty = value!),
            _buildTextField('البلد', (value) => _country = value!),
            _buildTextField('السعر لكل جلسة', (value) => _price = int.parse(value!), keyboardType: TextInputType.number),
                        _buildTextField(' مده الجلسه التي تريدها ', (value) => _moda = int.parse(value!), keyboardType: TextInputType.number),

            _buildFilePicker('البطاقة', _card, (file) => setState(() => _card = file)),
            _buildFilePicker('كارنيه النقابة', _unionCard, (file) => setState(() => _unionCard = file)),
            _buildFilePicker('شهادة التخرج', _graduationCertificate, (file) => setState(() => _graduationCertificate = file)),
            _buildFilePicker('السيرة الذاتية', _cv, (file) => setState(() => _cv = file)),
                        _buildFilePicker('الصورة السخصية ', _pp, (file) => setState(() => _pp = file)),

            _buildFilePicker('صورة مع البطاقة', _imageWithCard, (file) => setState(() => _imageWithCard = file)),
            _buildGenderField(),
            SizedBox(height: 20),
            CustomGeneralButton(
              onTap: _submitForm,
              text: 'ارسال',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, Function(String?) onSaved, {TextInputType keyboardType = TextInputType.text}) {
    final focusNode = FocusNode();
    return Container(
      width: 382,
      height: 72,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 268,
            child: Text(
              labelText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          Focus(
            child: Builder(
              builder: (context) {
                final isFocused = Focus.of(context).hasFocus;
                return Container(
                  width: 382,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: isFocused ? Color(0xFFD68FFF) : Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    textAlign: TextAlign.right,
                    keyboardType: keyboardType,
                    onSaved: onSaved,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال $labelText';
                      }
                      if (labelText == 'السعر لكل جلسة' && int.tryParse(value) == null) {
                        return 'الرجاء إدخال رقم صحيح';
                      }
                      return null;
                    },
                    focusNode: focusNode,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderField() {
    return Container(
      width: 382,
      height: 72,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 268,
            child: Text(
              'النوع',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          Container(
            width: 382,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _gender,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF100D10),
                      fontSize: 16,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
                _buildRadio('ذكر'),
                Text('ذكر'),
                _buildRadio('أنثى'),
                Text('أنثى'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String value) {
    return Radio(
      value: value,
      groupValue: _gender,
      onChanged: (String? newValue) {
        setState(() {
          _gender = newValue!;
        });
      },
    );
  }

  Widget _buildFilePicker(String labelText, File? file, Function(File) onFilePicked) {
    return Container(
      width: 382,
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 268,
            child: Text(
              labelText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF100D10),
                fontSize: 16,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          Container(
            width: 382,
            height: 50,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: file != null ? file.path.split('/').last : '',
                    ),
                    onTap: () async {
                      final file = await _getFile();
                      if (file != null) {
                        onFilePicked(file);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () async {
                    final file = await _getFile();
                    if (file != null) {
                      onFilePicked(file);
                    }
                  },
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_isSubmitting) return;
    setState(() {
      _isSubmitting = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final cardUrl = await uploadFile(_card);
      final unionCardUrl = await uploadFile(_unionCard);
      final graduationCertificateUrl = await uploadFile(_graduationCertificate);
      final cvUrl = await uploadFile(_cv);
      final imageWithCardUrl = await uploadFile(_imageWithCard);
      final pp = await uploadFile(_pp);

      User? user = FirebaseAuth.instance.currentUser;
      String? email = user?.email;

      if (email != null) {
        await _firestore.collection('Therapist_Information').doc(email).set({
          'name': _name,
          'specialty': _specialty,
          'country': _country,
          'gender': _gender,
          'price': _price,
          'Idcard': cardUrl,
          'unionCar': unionCardUrl,
          'graduationCertificate': graduationCertificateUrl,
          'cv': cvUrl,
          'imageWithIdCard': imageWithCardUrl,
          'email_th': email,
          "pp":pp,
          "moda":_moda,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('تم إرسال المعلومات بنجاح'),
          ));
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPagethr()),
        );
      }
    }

    setState(() {
      _isSubmitting = false;
    });
  }
}
