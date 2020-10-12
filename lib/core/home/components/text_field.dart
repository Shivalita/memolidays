import 'package:flutter/material.dart';

class CustomTextField extends TextField{

  CustomTextField({
    keyboard: TextInputType.text,
    hintText: Text, 
    iconparam: Icon,
    control: TextEditingController,
    }) :
    super(
      keyboardType: keyboard, 
      decoration: new InputDecoration(
        border: const OutlineInputBorder(), 
        icon: iconparam,
        hintText: hintText,
      ),
        
      controller: control,
    );
}
