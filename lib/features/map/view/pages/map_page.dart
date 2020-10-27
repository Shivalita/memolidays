//! Affichage de la page de map

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lat_lon_grid_plugin/lat_lon_grid_plugin.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      // center: LatLng(51.5, -0.09),
      zoom: 5,
    ),
    layers: [
      TileLayerOptions(
          urlTemplate: 'https://api.mapbox.com/styles/v1/antonin06/ckfnx5e3j05m019s0o8pjvs60/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW50b25pbjA2IiwiYSI6ImNrZm53ejI3NDBsbGQycnM1YXlsYzhtNTcifQ.IrQsUXT8P7nQZpkwuDtPjw',
          additionalOptions: {
            'accessToken' : 'pk.eyJ1IjoiYW50b25pbjA2IiwiYSI6ImNrZm53ejI3NDBsbGQycnM1YXlsYzhtNTcifQ.IrQsUXT8P7nQZpkwuDtPjw',
            'id' : 'mapbox.satellite'
          },
        ),
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            // point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
  );
}
}