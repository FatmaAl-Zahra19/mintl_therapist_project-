import 'package:flutter/material.dart';
import 'package:mintl555555555/core/constants.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/space_widget.dart';

class CustomGeneralButton3 extends StatelessWidget {
  const CustomGeneralButton3({Key? key,this.text,this.onTap,this.image,this.color,this.colorx})
      : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  final Image? image;
  final Color? color;
  final Color? colorx;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              width: 350,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: image,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 176,
                    child: Text(
                      text!,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: colorx,
                        fontSize: 12.5,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                        height: 0.10,
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
