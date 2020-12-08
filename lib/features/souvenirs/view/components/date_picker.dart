import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class DatePicker extends StatelessWidget {
  final Souvenir souvenir = souvenirsState.state.selectedSouvenir;
  
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: FormBuilderDateTimePicker(
        attribute: 'eventDate',
        initialValue: currentDate,
        firstDate: DateTime(currentDate.year - 20),
        lastDate: currentDate,
        inputType: InputType.date,
        format: DateFormat("yyyy-MM-dd"),
        decoration: InputDecoration(
          hintText: 'Date',
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(Icons.date_range, size: 20),
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
          ),
        ),
      ),
    );
    
  }
}
