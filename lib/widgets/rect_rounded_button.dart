import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RectRoundedButton extends StatelessWidget {
  const RectRoundedButton({Key? key, this.onPressed, required this.title, this.isLoading=false}) : super(key: key);

  final Function()? onPressed;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading 
          ? SizedBox(
              height: 25.h,
              width: 25.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.5.r,          
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                semanticsLabel: 'Linear progress indicator',
              ),
            ) 
          : FittedBox(child: Text(title)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    );
  }
}