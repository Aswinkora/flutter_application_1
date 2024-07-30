import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  String _fcmToken = '';
  String get username => _username;

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('RegisterDatabase')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          _username = snapshot['username'] ?? 'mobilenumber';
          _fcmToken = snapshot['fcmToken'] ?? '';
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
      notifyListeners();
    }
  }

  Future<void> saveFcmToken(String token) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('RegisterDatabase').doc(user.uid).update({
          'fcmToken': token,
        });
        _fcmToken = token;
        notifyListeners();
      } catch (e) {
        print('Error saving FCM token: $e');
      }
    }
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    notifyListeners();
  }
}
