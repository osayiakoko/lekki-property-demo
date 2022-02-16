import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({ Key? key, this.size, this.color }) : super(key: key);

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 25.r,
        width: size ?? 25.r,
        child: CircularProgressIndicator(
          color: color ?? KColorScheme.primary,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
