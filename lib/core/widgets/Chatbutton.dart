import 'package:flutter/material.dart';
import 'package:mintl555555555/core/utils/size_config.dart';

class Chatbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return        Positioned(
           right: SizeConfig.defaultSize!*2,
           left: SizeConfig.defaultSize!*2,
            bottom: SizeConfig.defaultSize! * 4,
          child: Container(
              width: 382,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
          color: Color(0xFFF6E4FF),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
          ),
              ),
              child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          SizedBox(
                              width: 154,
                              child: Text(
                                  'ابدا المحادثه الان',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color(0xFF100D10),
                                      fontSize: 20,
                                      fontFamily: 'Tajawal',
                                      fontWeight: FontWeight.w500,
                                      height: 0.06,
                                  ),
                              ),
                          ),
                      ],
                  ),
              ),
          ],
              ),
          ),
        );
     
    
     }
}
