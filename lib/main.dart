import 'package:flutter/material.dart';
import 'package:photo_location_app/providers/great_places.dart';
import 'package:photo_location_app/screens/place_list_screen.dart';
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
      child: const MaterialApp(
        home: PlaceList(),
      ),
    );
  }
}
