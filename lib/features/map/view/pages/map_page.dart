import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:user_location/user_location.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Souvenir> allSouvenirs;
  bool isLocationServiceEnabled;

  static const _markerSize = 30.0;
  List<Marker> _markers = [];
  final zoom = 5;

  // Used to trigger showing/hiding of popups.

  @override
  void initState() {
    allSouvenirs = souvenirsState.state.allSouvenirsList;
    isLocationServiceEnabled = souvenirsState.state.isLocalizationEnabled;

    super.initState();

    allSouvenirs.forEach((souvenir) {
      LatLng point = LatLng(souvenir.latitude, souvenir.longitude);
      souvenirsState.setState((state) => state.getSouvenirIcon(souvenir));
      Icon souvenirIcon = souvenirsState.state.currentSouvenirIcon;

      Marker souvenirMarker = 
          Marker(
            point: point,
            width: _markerSize,
            height: _markerSize,
            builder: (BuildContext context) => IconButton(
            icon: souvenirIcon,
            iconSize: _markerSize,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        // height: 250,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)) ,
                                  child: Container(
                                    height: 125,
                                    width: 125,
                                    child: Image.network("https://source.unsplash.com/random/?2", fit: BoxFit.cover)
                                  )
                                ),
                                SizedBox(width: 5),
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)) ,
                                  child: Container(
                                    
                                    height: 125,
                                    width: 125,
                                    child: Image.network("https://source.unsplash.com/random/?1", fit: BoxFit.cover)
                                  )
                                ),
                                SizedBox(width: 5),
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    height: 125,
                                    width: 125,
                                    child: Image.network("https://source.unsplash.com/random/?3", fit: BoxFit.cover)
                                  )
                                ),
                                SizedBox(width: 5),
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    height: 125,
                                    width: 125,
                                    child: Image.network("https://source.unsplash.com/random/?4", fit: BoxFit.cover)
                                  )
                                )
                                ]
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Titre du Souvenir",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red, size: 25
                                    ),
                                    Text(
                                      "SomeWhere",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "99/99/2020",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            FloatingActionButton(
                              onPressed: (){},
                              child: Icon(Icons.arrow_forward, color: Colors.orange),
                              backgroundColor: Colors.white,
                              elevation: 3,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  });
            }),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      );

      _markers.add(souvenirMarker);
    });
  }

  // ADD THIS
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  // ADD THIS
  List<Marker> markers = [];

  void zoomButton() {
    mapController.move(LatLng(35, 35), 5); //ZoomTo New LatLng and Zooming
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,
        updateMapLocationOnPositionChange: false,
        showMoveToCurrentLocationFloatingActionButton: false);
        //!
    return WillPopScope(
      onWillPop: () async {
        print('ON WILL POP');
        Get.toNamed('/home');
        return true;
      },
      child: Stack(
      // return Stack(
        children: [
          FlutterMap(
            options: new MapOptions(
              center: LatLng(46.611182, 2.436257),
              zoom: 5.0,
              plugins: [
                UserLocationPlugin(),
              ],
            ),
            layers: [MarkerLayerOptions(markers: markers), userLocationOptions],
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/antonin06/ckfnx5e3j05m019s0o8pjvs60/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW50b25pbjA2IiwiYSI6ImNrZm53ejI3NDBsbGQycnM1YXlsYzhtNTcifQ.IrQsUXT8P7nQZpkwuDtPjw',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiYW50b25pbjA2IiwiYSI6ImNrZm53ejI3NDBsbGQycnM1YXlsYzhtNTcifQ.IrQsUXT8P7nQZpkwuDtPjw',
                  'id': 'mapbox.satellite'
                },
              )),
              MarkerLayerWidget(options: MarkerLayerOptions(markers: _markers)),
            ],
          ),
        ],
      ),
    );
  }


  // void showPopupForFirstMarker() {
  //   _popupLayerController.togglePopup(_markers.first);
  // }
}