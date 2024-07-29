import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/userprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_application_1/screen/upload.dart';
import 'package:provider/provider.dart';

class Imagescreen extends StatefulWidget {
  final DateTime selectedDate;

  const Imagescreen({super.key, required this.selectedDate});

  @override
  State<Imagescreen> createState() => _ImagescreenState();
}

class _ImagescreenState extends State<Imagescreen> {
  ImagePicker picker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    Future<void> opencamera() async {
      if (await Permission.camera.request().isGranted) {
        final XFile? image =
            await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            file = image;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UploadScreen(
                    image: File(image.path),
                    selectedDate: widget.selectedDate,
                          username: Provider.of<UserProvider>(context, listen: false).username,

                  )));
        }
      }
    }

    Future<void> openGallary() async {
      if (await Permission.photos.request().isGranted) {
        final XFile? images =
            await picker.pickImage(source: ImageSource.gallery);
        if (images != null) {
          setState(() {
            file = images;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UploadScreen(
                    image: File(images.path),
                    selectedDate: widget.selectedDate,
                     username: Provider.of<UserProvider>(context, listen: false).username,

                  )));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  opencamera();
                },
                icon: Icon(Icons.camera_alt),
                label: Text('OPEN CAMERA')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  openGallary();
                },
                icon: Icon(Icons.photo_library),
                label: Text('Gallery')),
          ],
        ),
      ),
    );
  }
}
