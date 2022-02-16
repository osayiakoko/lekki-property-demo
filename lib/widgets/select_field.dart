import 'package:flutter/material.dart';
import 'package:lekki_proj_demo/utils/k_color_scheme.dart';

class SelectField extends StatelessWidget {

  final label;
  final items;
  final value;
  final onChange;

  const SelectField({Key? key, @required this.label, required this.items, required this.value, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(fontSize: 12, color: KColorScheme.primary),),
        DropdownButton<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 2,
            color: KColorScheme.primary,
          ),
          value: value,
          items: items, 
          onChanged: onChange
        ),
      ],
    );
  }
}
