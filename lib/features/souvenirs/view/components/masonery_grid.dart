import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/thumbnail.dart';
import 'package:transparent_image/transparent_image.dart';
import 'details_photo.dart';

class MasoneryGrid extends StatefulWidget {
  @override
  _MasoneryGridState createState() => _MasoneryGridState();
}

// List<ImageDetails> _images = [
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/VFRTXGw1VjU",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/7ybKmhDTcz0",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/S0hS0HfH_B8",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/8CGT0Kq6K3k",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/BchXuilibLA",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/2N-kwvSeU5U",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/tHXX4fl3-ms",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/cjBLfrjE-XU",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/RH0QUHYPeW4",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
//   ImageDetails(
//       imagePath: "https://source.unsplash.com/kaEhf0eZme8",
//       title: "Toto",
//       date: "14 Octobre 2020",
//       location: "Roanne",
//       comment: "Super Week-end à Rome!"
//   ),
// ];

class _MasoneryGridState extends State<MasoneryGrid> {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;
  List<Thumbnail> thumbnails = souvenirsState.state.selectedSouvenir.thumbnails;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.red, size: 35),
                  Text(
                    souvenir.place,
                    style: TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                souvenir.date,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              itemCount: thumbnails.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPhoto(
                          imagePath: thumbnails[index].path,
                          // title: _images[index].title,
                          // date: _images[index].date,
                          // location: _images[index].location,
                          // comment: _images[index].comment,
                          index: index,
                          thumbnails: thumbnails
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[350],
                              offset: Offset(1.0, 2.0),
                              blurRadius: 1.0,
                              spreadRadius: 1.0),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: thumbnails[index].path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
              }),
        ),
      ],
    )
  );
  }
}

class ImageDetails {
  final String imagePath;
  final String title;
  final String date;
  final String location;
  final String comment;
  ImageDetails({this.imagePath, this.title, this.date, this.location, this.comment});
}