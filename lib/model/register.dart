import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterModel {
  RegisterModel({
    this.id,
    required this.username,
    required this.mobilenumber,
    required this.housenumber,
    required this.buildingname,
    required this.street,
    required this.place,
  });
  String? id;
  String username;
  String mobilenumber;
  int housenumber;
  String buildingname;
  String street;
  String place;

  Map<String, dynamic> toMap() {
    return {
     
      'username': username,
      'mobilenumber': mobilenumber,
      'housenumber': housenumber,
      'buildingname': buildingname,
      'street': street,
      'place': place,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map,String id) {
    return RegisterModel(
    id: id,
      username: map['username'],
      mobilenumber: map['mobilenumber'],
      housenumber: map['housenumber'],
      buildingname: map['buildingname'],
      street: map['street'],
      place: map['place'], 
    );
  }
}

class RegisterDatabase {
  CollectionReference<Map<String, dynamic>> database() {
    return FirebaseFirestore.instance.collection('RegisterDatabase');
  }

  Future<void> senddata(RegisterModel register) async {
    try {
      await database().add(register.toMap());
      print('Data added');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<RegisterModel?> getdetails(String num) async {
    print('Searching for user with mobile number: $num');
    var query = await database().where('mobilenumber', isEqualTo: num).get();
    if (query.docs.isNotEmpty) {
      var doc=query.docs.first;
      var userdata = query.docs.first.data();
      return RegisterModel.fromMap(userdata,doc.id);
    } else {
      print('No user found with mobile number: $num');
      return null;
    }
  }
}
