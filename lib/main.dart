import 'package:flutter/material.dart';
import 'package:photo_location_app/providers/great_places.dart';
import 'package:photo_location_app/screens/add_place_screen.dart';
import 'package:photo_location_app/screens/detailed_photo_screen.dart';
import 'package:photo_location_app/screens/map-screen.dart';
import 'package:photo_location_app/screens/photo_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const PlaceList(),
        routes: <String, WidgetBuilder>{
          '/addPlace': (BuildContext context) => const AddPlace(),
          '/detailedPhoto': (BuildContext context) =>
              const DetailedPhotoScreen(),
        },
      ),
    );
  }
}
