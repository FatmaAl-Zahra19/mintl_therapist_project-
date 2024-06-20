import 'package:flutter/cupertino.dart';
import 'package:mintl555555555/core/utils/size_config.dart';
import 'package:mintl555555555/core/widgets/space_widget.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({Key? key, this.title, this.subTitle, this.image})
      : super(key: key);

  final String? title;
  final String? subTitle;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(18),
        SizedBox(
            height: SizeConfig.defaultSize! * 25, child: Image.asset(image!)),
        const VerticalSpace(12),
        Text(
          title!,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
            color: const Color(0xff2f2e41),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        const VerticalSpace(1),
        Text(
          subTitle!,
          style: TextStyle(
            color: Color(0xFF494649),
            fontSize: 16,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.w400,
            
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
