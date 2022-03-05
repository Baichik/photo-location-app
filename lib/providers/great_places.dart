import 'package:flutter/foundation.dart';
import 'package:photo_location_app/screens/place_list_screen.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<PhotoModel> _items = [];

  List<PhotoModel> get items {
    return [..._items];
  }
}
