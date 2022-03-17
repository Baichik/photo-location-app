import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_location_app/models/photo_model.dart';
import 'package:photo_location_app/widgets/place_input.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'package:photo_location_app/widgets/image_input.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LocationModel? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lon) {
    _pickedLocation = LocationModel(latitude: lat, longitude: lon);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) return;
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add a new place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageInput(_selectImage),
                const SizedBox(
                  height: 70,
                ),
                PlaceInput(_selectPlace),
              ],
            )),
            ElevatedButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
          ],
        ));
  }
}
