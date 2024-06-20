import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/homepage.dart';
import 'package:mintl555555555/therapy/login/NavigationPagethr.dart';

class ContactUsIsDoneTherpist extends StatelessWidget {
  const ContactUsIsDoneTherpist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
           Positioned(
                  right: SizeConfig.defaultSize!*2,
           left: SizeConfig.defaultSize!*2,
            top: SizeConfig.defaultSize! * 10,
            bottom:SizeConfig.defaultSize! * 10 ,
              child: Image.asset(
                            'assets/images/problem sent done uesr.png',
                            width: MediaQuery.of(context).size.width,
                        
            ),),
                  Positioned(
            left: SizeConfig.defaultSize! * 4,
            right: SizeConfig.defaultSize! * 4,
            bottom: SizeConfig.defaultSize! *4,
            child: 
           
          CustomGeneralButton(
                onTap: () {
               
                   Get.to(() => NavigationPagethr(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));
            
                },
                text: 'العوده للصفحه الرئيسيه',
              ),
              
            ),
      ],),
    );
  }
}