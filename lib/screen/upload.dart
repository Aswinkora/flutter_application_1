// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/photo.dart';
// import 'package:flutter_application_1/model/uploadimage.dart';
// import 'package:flutter_application_1/screen/tabs.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   final DateTime selectedDate;
//   UploadScreen({super.key, required this.image, required this.selectedDate});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   bool _isUploading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 300,
//                   width: 300,
//                   child: Image.file(
//                     widget.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _isUploading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: uploadImage,
//                       child: Text('Upload'),
//                     ),
//               if (_isUploading)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Uploading, please wait...'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void uploadImage() async {
//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       String? imageUrl = await uploadimage(widget.image);

//       if (imageUrl != null) {
//         PhotoDatabase().sendData(PhotoModel(
//           imageUrl: imageUrl,
//           user: 'user',
//           date: widget.selectedDate,
//         ));

//         setState(() {
//           _isUploading = false;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Upload successful!')),
//         );
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Tabs()));
//       } else {
//         throw Exception('Image upload failed');
//       }
//     } catch (e) {
//       setState(() {
//         _isUploading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     }
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/photo.dart';
// import 'package:flutter_application_1/model/uploadimage.dart';
// import 'package:flutter_application_1/screen/tabs.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   final DateTime selectedDate;

//   UploadScreen({super.key, required this.image, required this.selectedDate});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   bool _isUploading = false;
//   List<String> days = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDays();
//   }

//   Future<void> fetchDays() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('days')
//           .doc('settings')
//           .get();

//       if (snapshot.exists) {
//         Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//         if (data != null) {
//           setState(() {
//             days = List<String>.from(data['days'] ?? []);
//           });
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching days: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 300,
//                   width: 300,
//                   child: Image.file(
//                     widget.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _isUploading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: uploadImage,
//                       child: Text('Upload'),
//                     ),
//               if (_isUploading)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Uploading, please wait...'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void uploadImage() async {
//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       String? imageUrl = await uploadimage(widget.image);

//       if (imageUrl != null) {
//         await FirebaseFirestore.instance.collection('PhotoDatabase').doc('userId').collection('days').doc('image').set(
//           )

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Upload successful!')),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Tabs()),
//         );
//       } else {
//         throw Exception('Image upload failed');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
// }

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/uploadimage.dart';
// import 'package:flutter_application_1/screen/tabs.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   final DateTime selectedDate;
//   final String username;

//   UploadScreen({
//     super.key,
//     required this.image,
//     required this.selectedDate,
//     required this.username,
//   });

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   bool _isUploading = false;
//   List<String> days = [];
//   DateTime? startingDate;

//   @override
//   void initState() {
//     super.initState();
//     fetchDaysAndStartingDate();
//   }

//   Future<void> fetchDaysAndStartingDate() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('days')
//           .doc('settings')
//           .get();

//       if (snapshot.exists) {
//         Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//         if (data != null) {
//           setState(() {
//             days = List<String>.from(data['days'] ?? []);
//             startingDate = (data['baseDate'] as Timestamp?)?.toDate();
//           });
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching days and starting date: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 300,
//                   width: 300,
//                   child: Image.file(
//                     widget.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _isUploading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: uploadImage,
//                       child: Text('Upload'),
//                     ),
//               if (_isUploading)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Uploading, please wait...'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void uploadImage() async {
//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       String? imageUrl = await uploadimage(widget.image);

//       if (imageUrl != null) {
//         String dayName = getDayName(widget.selectedDate);

//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.username)
//             .collection(dayName)
//             .add({
//           'imageUrl': imageUrl,
//           'date': widget.selectedDate,
//           'username': widget.username,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Upload successful!')),
//         );
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => Tabs(user: widget.username)));
//       } else {
//         throw Exception('Image upload failed');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   String getDayName(DateTime date) {
//     if (startingDate == null) {
//       return 'error';
//     }
//     int diff = date.difference(startingDate!).inDays;
//     int index = diff % days.length;
//     return days[index];
//   }
// }

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/uploadimage.dart';
// import 'package:flutter_application_1/screen/tabs.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UploadScreen extends StatefulWidget {
//   final File image;
//   final DateTime selectedDate;
//   final String username;

//   UploadScreen({
//     super.key,
//     required this.image,
//     required this.selectedDate,
//     required this.username,
//   });

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {
//   bool _isUploading = false;
//   List<String> days = [];
//   DateTime? startingDate;
//   late String  phoneNumber;

//   @override
//   void initState() {
//     super.initState();
//     fetchDaysAndStartingDate();
//     _loadPhoneNumber();
//   }

//   Future<void> fetchDaysAndStartingDate() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('days')
//           .doc('settings')
//           .get();

//       if (snapshot.exists) {
//         Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//         if (data != null) {
//           setState(() {
//             days = List<String>.from(data['days'] ?? []);
//             startingDate = (data['baseDate'] as Timestamp?)?.toDate();
//           });
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching days and starting date: $e')),
//       );
//     }
//   }

//   // Future<void> _loadPhoneNumber() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     phoneNumber = prefs.getString('mobile')!; // Load phone number from SharedPreferences
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 300,
//                   width: 300,
//                   child: Image.file(
//                     widget.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _isUploading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: uploadImage,
//                       child: Text('Upload'),
//                     ),
//               if (_isUploading)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('Uploading, please wait...'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void uploadImage() async {
//   //   setState(() {
//   //     _isUploading = true;
//   //   });

//   //   try {
//   //     String? imageUrl = await uploadimage(widget.image);

//   //     if (imageUrl != null) {
//   //       String dayName = getDayName(widget.selectedDate);

//   //       await FirebaseFirestore.instance
//   //           .collection('users')
//   //           .doc(widget.username)
//   //           .collection(dayName)
//   //           .add({
//   //         'imageUrl': imageUrl,
//   //         'date': widget.selectedDate,
//   //         'username': widget.username,
//   //         'phoneNumber': phoneNumber ?? 'unknown', // Add phone number here
//   //       });

//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Upload successful!')),
//   //       );
//   //       Navigator.pushReplacement(
//   //           context,
//   //           MaterialPageRoute(
//   //               builder: (context) => Tabs(user: widget.username)));
//   //     } else {
//   //       throw Exception('Image upload failed');
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Upload failed: $e')),
//   //     );
//   //   } finally {
//   //     setState(() {
//   //       _isUploading = false;
//   //     });
//   //   }
//   // }
//   Future<void> _loadPhoneNumber() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     phoneNumber = prefs.getString('mobile') ?? 'unknown'; // Default to 'unknown' if null
//     print('Loaded Phone Number: $phoneNumber'); // Debug print
//   });
// }

// void uploadImage() async {
//   setState(() {
//     _isUploading = true;
//   });

//   try {
//     String? imageUrl = await uploadimage(widget.image);

//     if (imageUrl != null) {
//       String dayName = getDayName(widget.selectedDate);

//       // Debug print for phone number and other fields
//       print('Uploading Image with Details:');
//       print('Username: ${widget.username}');
//       print('Phone Number: $phoneNumber');
//       print('Image URL: $imageUrl');
//       print('Date: ${widget.selectedDate}');
//       print('Day Name: $dayName');

//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.username)
//           .collection(dayName)
//           .add({
//         'imageUrl': imageUrl,
//         'date': widget.selectedDate,
//         'username': widget.username,
//         'phoneNumber': phoneNumber, // Add phone number here
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload successful!')),
//       );
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Tabs(user: widget.username)));
//     } else {
//       throw Exception('Image upload failed');
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Upload failed: $e')),
//     );
//   } finally {
//     setState(() {
//       _isUploading = false;
//     });
//   }
// }

//   String getDayName(DateTime date) {
//     if (startingDate == null) {
//       return 'error';
//     }
//     int diff = date.difference(startingDate!).inDays;
//     int index = diff % days.length;
//     return days[index];
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/uploadimage.dart';
import 'package:flutter_application_1/screen/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadScreen extends StatefulWidget {
  final File image;
  final DateTime selectedDate;
  final String username;

  UploadScreen({
    super.key,
    required this.image,
    required this.selectedDate,
    required this.username,
  });

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _isUploading = false;
  List<String> days = [];
  DateTime? startingDate;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    print('Initializing UploadScreen'); // Debug print
    fetchDaysAndStartingDate();
    _loadPhoneNumber();
  }

  Future<void> fetchDaysAndStartingDate() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('days')
          .doc('settings')
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            days = List<String>.from(data['days'] ?? []);
            startingDate = (data['baseDate'] as Timestamp?)?.toDate();
          });
          print('Days and Starting Date fetched successfully');
        }
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching days and starting date: $e'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching days and starting date: $e')),
      );
    }
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loadedPhoneNumber =
        prefs.getString('mobile') ?? 'unknown'; // Default to 'unknown' if null
    print('Loaded Phone Number: $loadedPhoneNumber'); // Debug print
    setState(() {
      phoneNumber = loadedPhoneNumber;
    });
  }

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
                      onPressed: uploadImage,
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

  Future<void> uploadImage() async {
    print('Starting Image Upload'); // Debug print
    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl = await uploadimage(widget.image);
      print('Image URL: $imageUrl'); // Debug print

      if (imageUrl != null) {
        String dayName = getDayName(widget.selectedDate);

        // Debug print for phone number and other fields
        print('Uploading Image with Details:');
        print('Username: ${widget.username}');
        print('Phone Number: $phoneNumber');
        print('Image URL: $imageUrl');
        print('Date: ${widget.selectedDate}');
        print('Day Name: $dayName');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.username)
            .collection(dayName)
            .add({
          'imageUrl': imageUrl,
          'date': widget.selectedDate,
          'username': widget.username,
          'phoneNumber': phoneNumber, // Add phone number here
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful!')),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Tabs(user: widget.username)));
      } else {
        throw Exception('Image upload failed');
      }
    } catch (e) {
      print('Upload failed: $e'); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  String getDayName(DateTime date) {
    if (startingDate == null) {
      return 'error';
    }
    int diff = date.difference(startingDate!).inDays;
    int index = diff % days.length;
    return days[index];
  }
}
