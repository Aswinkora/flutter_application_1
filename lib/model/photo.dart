// import 'package:cloud_firestore/cloud_firestore.dart';

// class PhotoModel {
//   // ignore: non_constant_identifier_names
//   PhotoModel({this.imageurl, required this.user});
//   String user;
//   var imageurl;

//   Map<String, dynamic> tomap() {
//     return {
//       'user': user,
//       'imageurl': imageurl,
//     };
//   }

//   factory PhotoModel.fromMap(Map<String, dynamic> map) {
//     return PhotoModel(user: map['user'], imageurl: map['imageurl']);
//   }
// }

// class PhotoDatabase {
//   CollectionReference<Map<String, dynamic>> database() {
//     return FirebaseFirestore.instance.collection('PhotoDatabase');
//   }

//   Future<void> senddata(PhotoModel register) async {
//     try {
//       await database().add(register.tomap());
//       print('Data added');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PhotoModel {
  PhotoModel({required this.imageUrl, required this.user, required this.date});
  String user;
  String imageUrl;
  DateTime date;

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'imageUrl': imageUrl,
      'date': date,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      user: map['user'],
      imageUrl: map['imageUrl'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}

class PhotoDatabase {
  CollectionReference<Map<String, dynamic>> database(String day) {
    if (day.isEmpty || day.contains('/') || day.contains('.')) {
      throw ArgumentError('Invalid collection path: $day');
    }
    print("Database path: PhotoDatabase/$day");
    return FirebaseFirestore.instance
        .collection('PhotoDatabase')
        .doc(day)
        .collection('user');
  }

  Future<void> sendData(PhotoModel photo) async {
    try {
      String day = DateFormat('yyyy-MM-dd').format(photo.date);
      if (day.isEmpty || day.contains('/') || day.contains('.')) {
        throw ArgumentError('Invalid formatted day string: $day');
      }
      await database(day).add(photo.toMap());
      print('Data added');
    } catch (e) {
      print('Error: $e');
    }
  }
}
