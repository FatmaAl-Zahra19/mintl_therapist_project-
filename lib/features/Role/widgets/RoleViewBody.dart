import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/core/widgets/custom_buttons2.dart';
import 'package:mintl555555555/exp.dart';
import 'package:mintl555555555/features/user/Auth/presentation/pages/login/widgets/login_view_body.dart';
import 'package:mintl555555555/therapy/login/therapylog.dart';

class RoleViewBody extends StatefulWidget {
  const RoleViewBody({Key? key}) : super(key: key);

  @override
  State<RoleViewBody> createState() => _RoleViewBodyState();
}

class _RoleViewBodyState extends State<RoleViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/role_bac.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
             
            right: SizeConfig.defaultSize! * 2,
            top: SizeConfig.defaultSize! *10,

            child:InkWell(
              onTap: () {
                                                Get.to(() => Explor(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));

              },
              child: Icon(Icons.verified_outlined,color: Colors.lightGreen,))),
         Positioned(
          left: SizeConfig.defaultSize! * 2,
            right: SizeConfig.defaultSize! * 2,
            top: SizeConfig.defaultSize! *65,
          child:Column(
      children: [
        Text(
          'مرحبا بك  ',
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
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 42),
          child: Text(
            'تريد التسجيل كمعالج ام كمستخدم للتطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF494649),
              fontSize: 16.5,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w200,
              height: 0.06,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    ), ),
          Positioned(
            top: SizeConfig.defaultSize! * 14.5,
            left: SizeConfig.defaultSize! * 2.5,
            right: SizeConfig.defaultSize! * 3.5,
            child: Image.asset('assets/images/role.png'),
          ),
               Positioned(
            left: SizeConfig.defaultSize! * 4,
            right: SizeConfig.defaultSize! * 4,
            bottom: SizeConfig.defaultSize! * 10,
          child: CustomGeneralButton(
                text: 'مستخدم',
                onTap: () {
                Get.to(() => LoginViewBody(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));

                },

        ),),
        Positioned(
           left: SizeConfig.defaultSize! * 4,
            right: SizeConfig.defaultSize! * 4,
            bottom: SizeConfig.defaultSize! *4,
          child: CustomGeneralButton2(
                text: 'معالج',
onTap: (){
                  Get.to(() => LoginViewBodythe(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));

  
},
        ),),
        ],
      ),
    );
  }
}
