import 'dart:io';

import 'package:flutter/foundation.dart';

class LocationModel {
  final double? latitude;
  final double? longitude;
  final String? address;

  const LocationModel(
      {@required this.latitude, @required this.longitude, this.address});
}

class PhotoModel {
  final String? id;
  final LocationModel? location;
  final String? title;
  final File? image;

  PhotoModel(
      {@required this.id, @required this.location, @required this.title, @required this.image});
}
