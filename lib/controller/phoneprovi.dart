// import 'package:flutter/material.dart';

// class PhoneNumberProvider with ChangeNotifier {
//   String _phoneNumber = '';

//   String get phoneNumber => _phoneNumber;

//   void setPhoneNumber(String phoneNumber) {
//     _phoneNumber = phoneNumber;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberProvider with ChangeNotifier {
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  void loadPhoneNumber(String Mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', Mobile);
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobilenumber', phoneNumber);
    notifyListeners();
  }
}
