import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TextAreaField extends StatelessWidget {

  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final String? initiaValue;
  final bool? enabled;
  final bool filled;

  const TextAreaField(
    this.label,
    {
    Key? key, 
    this.validator, 
    this.controller,
    this.minLines,
    this.initiaValue,
    this.enabled,
    this.filled=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controller,
            validator: validator,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            initialValue: initiaValue,
            enabled: enabled,
            decoration: InputDecoration(
              labelText: label
            )
          )
        ],
      ),
    );
  }
}
