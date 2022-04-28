import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_location_app/models/photo_model.dart';

class MapScreen extends StatefulWidget {
  final LocationModel initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key? key,
      this.initialLocation = const LocationModel(),
      this.isSelecting = false})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  void initState() {
    _pickedLocation = LatLng(
        widget.initialLocation.latitude!, widget.initialLocation.longitude!);
    super.initState();
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        if (widget.isSelecting)
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
          )
      ]),
      body: GoogleMap(
        onTap: _selectLocation,
        markers: {
          Marker(
            markerId: const MarkerId('m1'),
            position:
                LatLng(_pickedLocation!.latitude, _pickedLocation!.longitude),
          )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude!,
              widget.initialLocation.longitude!),
          zoom: 16,
        ),
      ),
    );
    // LatLng? _pickedLocation;

    // void _selectLocation(LatLng position) {
    //   setState(() {
    //     _pickedLocation = position;
    //   });
    // }

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //       body: GoogleMap(
    //           initialCameraPosition: CameraPosition(
    //             target: LatLng(widget.initialLocation.latitude!,
    //                 widget.initialLocation.longitude!),
    //             zoom: 16,
    //           ),
    //           onTap: widget.isSelecting ? _selectLocation : null,
    //           markers: _pickedLocation == null
    //               ? null
    //               : {
    //                   Marker(
    //                       markerId: const MarkerId('m1'),
    //                       position: _pickedLocation!)
    //                 }));
  }
}
