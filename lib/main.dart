import 'package:flutter/material.dart';
import 'package:movies_app/src/routes/router.dart';

void main() => runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: getRoutes(),
    ));
