import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Colors.black),
      child: Card(
        elevation: 3,
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(10),
          title: Text('More infos'),
          children: <Widget>[
            FormBuilderTextField(
              attribute: 'email',
              readOnly: false,
              decoration: InputDecoration(
                hintText: 'Email',
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
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              attribute: 'phone',
              readOnly: false,
              decoration: InputDecoration(
                hintText: 'Phone',
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
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              attribute: 'comment',
              readOnly: false,
              decoration: InputDecoration(
                hintText: 'Comment',
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
            )
          ],
        ),
      ),
    );
  }
}
