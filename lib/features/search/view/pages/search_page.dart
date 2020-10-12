//! Affichage de la page de recherche

import 'package:flutter/material.dart';
import 'package:memolidays/features/search/view/components/search_bar.dart';
import 'package:memolidays/features/search/view/components/search_result.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SearchBar(),
          SearchResult()
        ],
      ),
      )
    );
  }
}
