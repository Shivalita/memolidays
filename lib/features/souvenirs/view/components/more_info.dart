import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/view/components/input.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Colors.black),
      child: Card(        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: ExpansionTile(          
          childrenPadding: EdgeInsets.all(10),
          title: Text('More infos'),
          children: <Widget>[
            // Material(
            //   elevation: 3,
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   child: FormBuilderTextField(
            //     attribute: 'email',
            //     readOnly: false,
            //     decoration: InputDecoration(
            //       hintText: 'Email',
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       prefixIcon: Icon(Icons.mail, size: 20),
            //       enabledBorder: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.black54),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.orange),
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.only(
            //         left: 16,
            //         right: 20,
            //         top: 14,
            //         bottom: 14,
            //       ),
            //     ),
            //   ),
            // ),
            Input('Comment', Icon(Icons.comment, size: 20)),
            SizedBox(height: 10,),
            Input('Phone', Icon(Icons.phone, size: 20)),
            SizedBox(height: 10,),
            Input('Email', Icon(Icons.email, size: 20)),

            // Material(
            //   elevation: 3,
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   child: FormBuilderTextField(
            //     attribute: 'phone',
            //     readOnly: false,
            //     decoration: InputDecoration(
            //       hintText: 'Phone',
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       prefixIcon: Icon(Icons.phone, size: 20),
            //       enabledBorder: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.black54),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.orange),
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.only(
            //         left: 16,
            //         right: 20,
            //         top: 14,
            //         bottom: 14,
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Material(
            //   elevation: 3,
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   child: FormBuilderTextField(
            //     attribute: 'comment',
            //     readOnly: false,
            //     decoration: InputDecoration(
            //       hintText: 'Comment',
            //       filled: true,
            //       fillColor: Colors.grey[100],
            //       prefixIcon: Icon(Icons.comment, size: 20),
            //       enabledBorder: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.black54),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(30)),
            //         borderSide: BorderSide(color: Colors.orange),
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.only(
            //         left: 16,
            //         right: 20,
            //         top: 14,
            //         bottom: 14,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
