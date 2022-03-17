import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _img;

  Future<void> takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final photo =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (photo == null) return;
    setState(() {
      _img = File(photo.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo.path);
    final savedImg = await _img!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: _img != null
                ? Image.file(
                    _img!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : const Center(
                    child: Text('No image taken'),
                  ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              // ignore: deprecated_member_use
              child: FlatButton.icon(
            onPressed: takePicture,
            icon: const Icon(
              Icons.camera,
            ),
            label: const Text('Take picture'),
            textColor: Theme.of(context).primaryColor,
          ))
        ],
      ),
    );
  }
}
