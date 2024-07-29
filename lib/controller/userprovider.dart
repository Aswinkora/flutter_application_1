import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
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
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
      notifyListeners();
    }
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }
}