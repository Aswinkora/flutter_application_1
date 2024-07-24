import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/screen/terms.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController buildingNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'images/img.png',
              width: 200,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 150),
                  TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: mobileNumberController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: houseNumberController,
                    decoration: InputDecoration(
                      labelText: 'House Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: buildingNameController,
                    decoration: InputDecoration(
                      labelText: 'Building Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: 'Street',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: placeController,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      create();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text('REGISTER'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Back To Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void create() {
    
    String user = userNameController.text;
    String mobile = mobileNumberController.text;
    String Street = streetController.text;
    int housenum = int.parse(houseNumberController.text);
    String building = buildingNameController.text;
    String place = placeController.text;
   
    RegisterModel newmodel = RegisterModel(
        username: user,
        mobilenumber: mobile,
        housenumber: housenum,
        buildingname: building,
        street: Street,
        place: place , );
    RegisterDatabase().senddata(newmodel);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Terms()));
  }
}
