import 'dart:io';

import 'package:flutter/foundation.dart';

class LocationModel {
  final double? latitude;
  final double? longitude;
  final String? adress;

  LocationModel(
      {@required this.latitude, @required this.longitude, this.adress});
}

class PhotoModel {
  final String? id;
  final LocationModel? location;
  final File? image;

  PhotoModel(
      {@required this.id, @required this.location, @required this.image});
}
