import 'package:flutter/material.dart';

class DetailsPhoto extends StatelessWidget {
  final String imagePath;
  final String title;
  final int index;
  DetailsPhoto({this.imagePath, this.title, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imagePath,
                    scale: 0.3,
                  ),
                ),
              ),
              // Expanded(
              //   child: Hero(
              //     tag: 'logo$index',
              //     child: Container(
              //       decoration: BoxDecoration(
              //         // borderRadius: BorderRadius.only(
              //         //     bottomLeft: Radius.circular(30),
              //         //     bottomRight: Radius.circular(30)),
              //         image: DecorationImage(
              //           image: NetworkImage(imagePath),
              //           fit: BoxFit.contain,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
