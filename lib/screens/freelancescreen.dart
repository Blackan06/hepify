import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FreeLance extends StatefulWidget {
  const FreeLance({super.key});
  static const rounteName = '/freelancer';
  @override
  State<FreeLance> createState() => _FreeLanceState();
}

class _FreeLanceState extends State<FreeLance> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.camera);
    // getting a directory path for saving

    setState(() {
      imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Color(0xFF4c53A5),
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Color(0xFF4c53A5),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
