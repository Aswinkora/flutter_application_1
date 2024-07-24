// import 'dart:io';

// import 'package:flutter/material.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   const UploadScreen({super.key, required this.image});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(shape: BoxShape.circle),
//                 height: 300,
//                 width: 300,
//                 child: Image.file(
//                   widget.image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
