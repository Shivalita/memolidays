import 'package:flutter/material.dart';
import 'package:material_tag_editor/tag_editor.dart';


class Tags extends StatefulWidget {
  Tags({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  List<String> values = [];

  onDelete(index) {
    setState(() {
      values.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TagEditor(
              length: values.length,
              delimeters: [',', ' '],
              hasAddButton: false,
              resetTextOnSubmitted: true,
              onSubmitted: (outstandingValue) {
                setState(() {
                  values.add(outstandingValue);
                });
              },
              inputDecoration: const InputDecoration(
                hintText: 'Add Category',
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
              onTagChanged: (newValue) {
                setState(() {
                  values.add(newValue);
                });
              },
              tagBuilder: (context, index) => _Chip(
                index: index,
                label: values[index],
                onDeleted: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 3,
      backgroundColor: Colors.orange,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
