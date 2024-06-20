import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mintl555555555/core/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? inputType;
   final VoidCallback? onTapp;
  final Widget? suffexIcon;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final int? maxLines;
  final String? hintText;
  final Image? image;
  final Color? color;
  final TextEditingController? nameControllerr;
  const CustomTextFormField({
    Key? key,
    @required this.inputType,
    this.suffexIcon,
    @required this.onSaved,
    this.onChanged,
    this.maxLines,
    this.hintText,
    this.image,
    this.color,
    this.onTapp ,
    @required this.nameControllerr, 
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
   
 

    return TextFormField(
      onTap:onTapp,
      controller: nameControllerr,
      textAlign: TextAlign.end,
      keyboardType: inputType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      decoration: InputDecoration(
      prefixIcon: image,
      hintText: hintText,
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
      color: kMainColor,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFCCCCCC),
            )),
      ),
    );
  }
}
