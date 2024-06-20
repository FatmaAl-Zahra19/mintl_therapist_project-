import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mintl555555555/core/constants.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons3.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/AuthService.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/signup.dart';
import 'package:mintl555555555/therapy/login/NavigationPagethr.dart';
import 'package:mintl555555555/therapy/login/outConditions.dart';

class LoginViewBodythe extends StatelessWidget {
  final AuthService _authService = AuthService();

  LoginViewBodythe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/onbording_bak.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: SizeConfig.defaultSize! * 2,
              right: SizeConfig.defaultSize! * 2,
              top: SizeConfig.defaultSize! * 60,
              child: Text(
                'إنشاء حساب ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                  height: 0.07,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            Positioned(
              top: SizeConfig.defaultSize! * 16,
              left: SizeConfig.defaultSize! * 3.5,
              right: SizeConfig.defaultSize! * 3.5,
              child: Image.asset('assets/images/sign_login.png'),
            ),
            Positioned(
              left: SizeConfig.defaultSize! * 3,
              right: SizeConfig.defaultSize! * 3,
              bottom: SizeConfig.defaultSize! * 20,
              child: CustomGeneralButton3(
                onTap: () async{
                        dynamic result = await _authService.signInWithGoogle();
                  if (result != null) {
                    bool isComplete = await _authService.isDataComplete();
                    if (isComplete) {
                      Get.off(() => NavigationPagethr());
                    } else {
                      Get.off(() => OutsideCondition(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 500));
                    }
                  }
                },
               
                text: 'إنشاء حساب باستخدام جوجل',
                image: Image.asset('assets/images/Google.png'),
                color: kMainColor,
              ),
            ),
            Positioned(
              left: SizeConfig.defaultSize! * 3,
              right: SizeConfig.defaultSize! * 3,
              bottom: SizeConfig.defaultSize! * 15,
              child: CustomGeneralButton3(
                onTap: () {
           
                },
                text: 'إنشاء حساب باستخدام الفيس بوك',
                image: Image.asset('assets/images/Facebook.png'),
                color: Color.fromARGB(255, 59, 88, 152),
                colorx: Colors.white,
              ),
            ),
            Positioned(
              left: SizeConfig.defaultSize! * 3,
              right: SizeConfig.defaultSize! * 3,
              bottom: SizeConfig.defaultSize! * 10,
              child: CustomGeneralButton3(
                onTap: () {},
                text: 'إنشاء حساب باستخدام apple',
                image: Image.asset('assets/images/Apple.png'),
                color: Colors.black,
                colorx: Colors.white,
              ),
            ),
  ],
        ),
      ),
    );
  }
}
