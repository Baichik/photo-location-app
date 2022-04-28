// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:photo_location_app/helpers/network_helper.dart';
import 'package:photo_location_app/models/photo_model.dart';
import 'package:photo_location_app/screens/map_screen.dart';

class PlaceInput extends StatefulWidget {
  final Function onSlect;
  const PlaceInput(this.onSlect, {Key? key}) : super(key: key);

  @override
  State<PlaceInput> createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  String? _previewImagePath;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  void _showPreview(double lat, double lon) {
    final staticMapImagePath =
        NetworkHelper.generateLocationPreviewImage(lat, lon);
    setState(() {
      _previewImagePath = staticMapImagePath;
    });
  }

  Future<void> _getLocation() async {
    final locData = await Location().getLocation();
    _showPreview(locData.latitude!, locData.longitude!);
    widget.onSlect(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(
                  initialLocation: LocationModel(
                      latitude: locData.latitude, longitude: locData.longitude),
                  isSelecting: true,
                )));
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSlect(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Container(
              height: 170,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: _previewImagePath == null
                  ? const Text('No location enabled')
                  : Image.network(
                      _previewImagePath!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: const Icon(Icons.map_outlined),
                label: const Text('Select on map '),
                textColor: Theme.of(context).primaryColor,
                onPressed: _selectOnMap,
              ),
            ],
          )
        ],
      ),
    );
  }
}
