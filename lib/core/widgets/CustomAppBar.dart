import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/exp.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:  SizeConfig.defaultSize!*7,
        right: SizeConfig.defaultSize!*2,
              left:SizeConfig.defaultSize!*2 ,
      child: Container(
      
        width: 300,
        height: 44,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LeftSide(),
            _RightSide(),
          ],
        ),
      ),
    );
  }
}

class _LeftSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Avatar(),
          const SizedBox(width: 16),
          Container(
            width: 24,
            height: 24,
            child: Stack(children: [
              Image.asset("assets/images/notfic.png")
            ]),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              child: Image.asset('assets/images/smiling-face-with-heart-eyes.png'),
              width: 44,
              height: 44,
              decoration: ShapeDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.4, 0.4),
                  radius: 1.25,
                  colors: [
                   
                    
                   
                    Color(0xFFE80D69),
                     Color(0xFFF9BCA7),
                     Color(0xBC9F16E4),
                      Color(0xFF9F16E4),
                  ],
                ),
                shape: OvalBorder(),
              ),
            ),
          ),
 ],
      ),
    );
  }
}

class _RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    
                    Get.to(() => Explor(), 
                        transition: Transition.downToUp,
                        duration: Duration(milliseconds: 500));
                  
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(children: [
                      Image.asset('assets/images/gift.png')
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 24,
            height: 24,
            child: Stack(children: [
              Image.asset("assets/images/menu-hamburger.png")
            ]),
          ),
        ],
      ),
    );
  }
}