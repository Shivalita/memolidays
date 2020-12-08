import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatelessWidget {
  String attribute;
  Icon icon;

  Input(String attribute, Icon icon) {
    this.attribute = attribute;
    this.icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: FormBuilderTextField(
        attribute: attribute.toLowerCase(),
        readOnly: false,
        decoration: InputDecoration(
          hintText: attribute,
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: icon,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.orange),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
        )),
    ));
  }
}
