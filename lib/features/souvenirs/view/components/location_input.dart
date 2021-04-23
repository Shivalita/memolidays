import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';

class LocationInput extends StatelessWidget {
  String attribute;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return MapBoxPlaceSearchWidget(
      popOnSelect: false,
      apiKey: "pk.eyJ1IjoibWVtb2xpZGF5cyIsImEiOiJja25mczE5aDAyNDV0MnhtcjF6Yjk2MW01In0.oHH0Xh17MZp1GDSVBj8ISA",
      // limit: 10,
      searchHint: 'Location',
      onSelected: (place) { souvenirsState.setState((state) async => state.updateLocationInput(place)); },
      context: context,
    );

    // return Column(
    //   children: [
    //     MapBoxPlaceSearchWidget(
    //       popOnSelect: false,
    //       apiKey: "pk.eyJ1IjoibWVtb2xpZGF5cyIsImEiOiJja25mczE5aDAyNDV0MnhtcjF6Yjk2MW01In0.oHH0Xh17MZp1GDSVBj8ISA",
    //       // limit: 10,
    //       searchHint: 'Location',
    //       onSelected: (place) { souvenirsState.setState((state) async => state.updateLocationInput(place)); },
    //       context: context,
    //     ),

    //     Visibility(
    //       visible: false,
    //       child: FormBuilderTextField(
    //         attribute: 'location',
    //         readOnly: true,
    //       ),
    //     )
    //   ],
    // );
  } 
}
