import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/screen/terms.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/userprovider.dart';

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
  final TextEditingController otpController = TextEditingController();

  bool isMobileVerified = false;
  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/img2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: phonevalidate,
                      maxLength: 10,
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(),
                        suffixIcon: isMobileVerified
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        if (value.length == 10 && phonevalidate(value) == null) {
                          verifyPhoneNumber(value);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: houseNumberController,
                        decoration: InputDecoration(
                          labelText: 'House Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: buildingNameController,
                      decoration: InputDecoration(
                        labelText: 'Building Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: streetController,
                      decoration: InputDecoration(
                        labelText: 'Street',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: placeController,
                      decoration: InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isMobileVerified ? create : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 237, 34, 102),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text('REGISTER'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back To Login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber', // Ensure the country code is correct
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          isMobileVerified = true;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error message'),
              content: Text(e.message ?? 'Verification failed'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
        });
        showOtpPopup();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  void showOtpPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            controller: otpController,
            decoration: InputDecoration(
              labelText: 'OTP',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                validateOtp();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void validateOtp() async {
    String enteredOtp = otpController.text;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: enteredOtp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        isMobileVerified = true;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error message'),
            content: Text('Invalid OTP'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  void create() async {
    String user = userNameController.text;
    String mobile = mobileNumberController.text;
    String Street = streetController.text;
    String housenumstr = houseNumberController.text;
    String building = buildingNameController.text;
    String place = placeController.text;

    if (user.isEmpty ||
        mobile.isEmpty ||
        Street.isEmpty ||
        (housenumstr.toString().isEmpty) ||
        building.isEmpty ||
        place.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error message'),
            content: Text('All fields are required'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else if (phonevalidate(mobile.toString()) != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error message'),
            content: Text('Fill mobile number properly'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } else {
      int housenum = int.parse(housenumstr);
      RegisterModel newmodel = RegisterModel(
        username: user,
        mobilenumber: mobile,
        housenumber: housenum,
        buildingname: building,
        street: Street,
        place: place,
      );
      await RegisterDatabase().senddata(newmodel);
      Provider.of<UserProvider>(context, listen: false).setUsername(user);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Terms(username: user),
        ),
      );
    }
  }

  String? phonevalidate(value) {
    if (value.isEmpty) {
      return null;
    } else if (value.length < 10) {
      return 'Please enter the full number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter valid numbers';
    }
    return null;
  }
}
