library movies.globals;

import 'package:flutter/material.dart';

final String uri_api = "api.themoviedb.org";
final String api_key = "58b1875ba27f86b4a94c1393c03e4a5e";

Widget validSnapshot(AsyncSnapshot snapshot, var result) {
  Widget child;

  if (!snapshot.hasData) {
    child = Center(child: Text("No found movies"));
  } else if (snapshot.hasError) {
    child = Center(child: Text("Got an error"));
  } else if (snapshot.hasData) {
    child = result();
  } else {
    child = Center(
      child: CircularProgressIndicator(),
    );
  }

  return child;
}
