import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: 'title',
      readOnly: false,
      decoration: InputDecoration(
        hintText: 'Title',
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 20,
          top: 14,
          bottom: 14,
        ),
      ),
    );
  }
}
