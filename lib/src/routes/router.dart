import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/details_movie_page.dart';
import 'package:movies_app/src/pages/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/': (BuildContext context) => HomePage(),
    'detailsMovie': (BuildContext context) => DetailsMoviePage(),
  };
}
