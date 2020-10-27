import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  void addLocation(MapboxMapController controller) async {
    mapController.addSymbol(SymbolOptions(
      geometry: LatLng(45.763829, 4.836872),
      iconImage: "marker-15",
      iconSize: 1,
      iconColor: "rgb(255,0,0)"
    ));
  }

  LatLng _center;
  Position currentLocation;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    // print('center $_center');
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          MapboxMap(
            myLocationEnabled: true,
            myLocationRenderMode: MyLocationRenderMode.GPS,
            styleString: "mapbox://styles/antonin06/ckfnx5e3j05m019s0o8pjvs60",
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: () => addLocation(mapController),
            initialCameraPosition: CameraPosition(target: _center, zoom: 4),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                FloatingActionButton(
                    child: Icon(Icons.zoom_in),
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomIn());
                    }),
                SizedBox(height: 10),
                FloatingActionButton(
                    child: Icon(Icons.zoom_out),
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomOut());
                    }),
                SizedBox(height: 10),
                FloatingActionButton(
                    child: Icon(Icons.location_on),
                    onPressed: () {
                      mapController.animateCamera(
                          CameraUpdate.newLatLngZoom(_center, 12));
                    }),
                SizedBox(height: 10),
                FloatingActionButton(
                    child: Icon(Icons.search),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                                child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              height: 350,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [Text("Hello world")],
                              ),
                            ));
                          });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
