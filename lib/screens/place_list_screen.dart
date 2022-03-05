import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your places')),
      body: const Center(
          child: SpinKitThreeBounce(
        color: Colors.black87,
        size: 25,
      )),
    );
  }
}
