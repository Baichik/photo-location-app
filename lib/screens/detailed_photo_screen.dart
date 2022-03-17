import 'package:flutter/material.dart';
import 'package:photo_location_app/providers/great_places.dart';
import 'package:photo_location_app/screens/map-screen.dart';
import 'package:provider/provider.dart';

class DetailedPhotoScreen extends StatelessWidget {
  const DetailedPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPhoto =
        Provider.of<GreatPlaces>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPhoto.title!),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPhoto.image!,
                fit: BoxFit.cover,
                width: double.infinity,
              )),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Text(
              selectedPhoto.location!.address!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    initialLocation: selectedPhoto.location!,
                    isSelecting: false,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'The photo was taken at ${selectedPhoto.id!}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
