import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
class StorageService {
  Future<String> downloadFileURL(String filePath) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String downloadURL = await storage.ref(filePath).getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error: $e");
      return "";
    }
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
    String url = await StorageService().downloadFileURL('image');
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage Example'),
      ),
      body: Center(
        child: imageUrl.isEmpty
            ? CircularProgressIndicator()
            : ImageScreen(imageUrl: imageUrl),
      ),
    );
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class AuthService {
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
  }
}




class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}


