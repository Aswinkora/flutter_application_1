import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/register.dart';

class UserProvider extends ChangeNotifier {
  RegisterModel? registerModel;
  RegisterModel? get regi => registerModel;
   void setRegisterModel(RegisterModel model) {
    registerModel = model;
    notifyListeners();
  }
   void clearRegisterModel() {
    registerModel = null;
    notifyListeners();
  }
}
