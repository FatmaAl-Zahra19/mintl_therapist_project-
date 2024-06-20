import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/custom_buttons.dart';
import 'package:mintl555555555/core/widgets/custom_buttons2.dart';
import 'package:mintl555555555/features/Role/widgets/RoleViewBody.dart';
import 'package:mintl555555555/features/on%20Boarding/presentation/widgets/custom_indicator.dart';
import 'package:mintl555555555/features/on%20Boarding/presentation/widgets/custom_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({Key? key}) : super(key: key);

  @override
  _OnBoardingViewBodyState createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController,
        ),

     Positioned(
            left: SizeConfig.defaultSize! * 4,
            right: SizeConfig.defaultSize! * 4,
            bottom: SizeConfig.defaultSize! * 10,
            child: CustomGeneralButton(
              onTap: () {
              
  if (pageController!.page! < 1) {
                    pageController?.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  } else {
                  Get.to(() => RoleViewBody(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));
                }
              },
              text: pageController!.hasClients
                  ? (pageController?.page == 1 ? 'ابدا' : 'التالى')
                  : 'التالي',
                  
            )),
                Positioned(
            left: SizeConfig.defaultSize! * 4,
            right: SizeConfig.defaultSize! * 4,
            bottom: SizeConfig.defaultSize! *4,
            child: 
            Visibility(
              child: CustomGeneralButton2(
                onTap: () {
               
                    Get.to(() => RoleViewBody(), transition: Transition.rightToLeft , duration: Duration(milliseconds: 500));
            
                },
                text: 'تخطي ',
              ),
              visible: pageController!.hasClients
              ? (pageController?.page == 1 ? false : true)
              : true,
            )),
 
      ],
    );
  }
}
