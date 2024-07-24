import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?>uploadimage(File image)async{
   try {
      String filename = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('image/$filename');
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageurl = await taskSnapshot.ref.getDownloadURL();
      return imageurl;
    } catch (e) {
      print('Error uploading image$e');
    }
    return null;
  }
