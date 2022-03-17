import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_location_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addPlace');
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPhoto(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const SpinKitThreeBounce(
                  color: Colors.black,
                )
              : Consumer<GreatPlaces>(
                  child: const Center(
                    child: Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                      ? ch!
                      : ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, index) => ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image!)),
                            title: Text(greatPlaces.items[index].title!),
                            subtitle: Text(
                              greatPlaces.items[index].location!.address!,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/detailedPhoto',
                                arguments: greatPlaces.items[index].id,
                              );
                            },
                          ),
                        ),
                ),
        ));
  }
}
