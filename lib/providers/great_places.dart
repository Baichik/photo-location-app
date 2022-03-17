import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:photo_location_app/helpers/network_helper.dart';
import 'package:intl/intl.dart';

import '../models/photo_model.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<PhotoModel> _items = [];

  List<PhotoModel> get items {
    return [..._items];
  }

  PhotoModel findById(String id) {
    return _items.firstWhere((photo) => photo.id == id);
  }

  Future<void> addPlace(
      String title, File image, LocationModel pickedLocation) async {
    final adress = await NetworkHelper.getPlaceAdress(
        pickedLocation.latitude!, pickedLocation.longitude!);

    final updatedLocation = LocationModel(
        latitude: pickedLocation.latitude!,
        longitude: pickedLocation.longitude!,
        address: adress);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    final newPlace = PhotoModel(
        id: formattedDate,
        location: updatedLocation,
        title: title,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_photos', {
      'id': newPlace.id as Object,
      'title': newPlace.title as Object,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitude as Object,
      'loc_lon': newPlace.location!.longitude as Object,
      'address': newPlace.location!.address as Object
    });
  }

  Future<void> fetchAndSetPhoto() async {
    final listOfData = await DBHelper.getData('user_photos');
    _items = listOfData
        .map((item) => PhotoModel(
            id: item['id'],
            location: LocationModel(
                latitude: item['loc_lat'],
                longitude: item['loc_lon'],
                address: item['address']),
            title: item['title'],
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
