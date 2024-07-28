import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screen/frontscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Frontscreen(),
        routes: {
          '/login': (context) => Login(),
        },
      ),
    );
  }
}
