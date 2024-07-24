// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBCUKblUCTp6zu7gRpG7QHJ8PwVVIEQ9vk',
    appId: '1:557985078163:web:1158ffd84b1b0e5504a666',
    messagingSenderId: '557985078163',
    projectId: 'shopping-eaeab',
    authDomain: 'shopping-eaeab.firebaseapp.com',
    storageBucket: 'shopping-eaeab.appspot.com',
    measurementId: 'G-LEFJSH5B6J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_ntex3JSCFUEhgc30fRPmJo3O7FnV--Y',
    appId: '1:557985078163:android:d1f24910330fd93104a666',
    messagingSenderId: '557985078163',
    projectId: 'shopping-eaeab',
    storageBucket: 'shopping-eaeab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoAHO6v6FnxurQ1_x2w5RKclG4BWezxe8',
    appId: '1:557985078163:ios:8f4f8aa8f12ae28204a666',
    messagingSenderId: '557985078163',
    projectId: 'shopping-eaeab',
    storageBucket: 'shopping-eaeab.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBCUKblUCTp6zu7gRpG7QHJ8PwVVIEQ9vk',
    appId: '1:557985078163:web:b3a88cba99d4df8804a666',
    messagingSenderId: '557985078163',
    projectId: 'shopping-eaeab',
    authDomain: 'shopping-eaeab.firebaseapp.com',
    storageBucket: 'shopping-eaeab.appspot.com',
    measurementId: 'G-YCE5E65YGW',
  );
}
