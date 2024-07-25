import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/uploadimage.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   const UploadScreen({super.key, required this.image});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('images/img2.png'), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(30)),
//                   height: 300,
//                   width: 300,
//                   child: Image.file(
//                     widget.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     upload();
//                   },
//                   child: Text('upload'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void upload() {
//     uploadimage(widget.image);
//   }
// }
class UploadScreen extends StatefulWidget {
  final File image;
  const UploadScreen({super.key, required this.image});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/img2.png'), 
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 300,
                  width: 300,
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _isUploading 
                ? CircularProgressIndicator() 
                : ElevatedButton(
                    onPressed: _uploadImage,
                    child: Text('Upload'),
                  ),
              if (_isUploading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Uploading, please wait...'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    try {
      await uploadimage(widget.image);
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload successful!')),
      );
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }
}