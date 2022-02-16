import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';

class PropertyAttribute extends StatelessWidget {
  final IconData icon; 
  final String text;
  Color? iconColor;
  bool boldText;

  PropertyAttribute(this.icon, this.text, { Key? key, this.iconColor, this.boldText=false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(icon, 
          color: iconColor ?? KColorScheme.grey.withOpacity(0.5) 
        ),
        SizedBox(width: 4.w),
        Text(text, 
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontWeight: boldText ? FontWeight.w600 : FontWeight.w500, color: KColorScheme.grey)
          ),
      ],
    );
  }
}
