import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {

  final String label;
  final bool intValue;
  final TextEditingController controller;
  final bool readOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;

  const InputField(this.label, this.controller, {Key? key, this.validator, this.intValue=true, this.readOnly=false, this.onTap}) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        autocorrect: false,
        controller: widget.controller,
        validator: widget.validator,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        keyboardType: widget.intValue ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        inputFormatters: widget.intValue ? [
          FilteringTextInputFormatter.digitsOnly
        ] : null, 
      ),
    );
  }
}
