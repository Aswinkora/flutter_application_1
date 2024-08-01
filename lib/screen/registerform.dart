// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/model/register.dart';
// import 'package:flutter_application_1/screen/terms.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/controller/userprovider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegistrationForm extends StatefulWidget {
//   const RegistrationForm({super.key});

//   @override
//   State<RegistrationForm> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();
//   final TextEditingController houseNumberController = TextEditingController();
//   final TextEditingController buildingNameController = TextEditingController();
//   final TextEditingController streetController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();

//   bool isMobileVerified = false;
//   String verificationId = '';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 150),
//                     TextFormField(
//                       controller: userNameController,
//                       decoration: InputDecoration(
//                         labelText: 'User Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       validator: phonevalidate,
//                       maxLength: 10,
//                       controller: mobileNumberController,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         labelText: 'Mobile Number',
//                         border: OutlineInputBorder(),
//                         suffixIcon: isMobileVerified
//                             ? Icon(Icons.check, color: Colors.green)
//                             : null,
//                       ),
//                       keyboardType: TextInputType.phone,
//                       onChanged: (value) {
//                         if (value.length == 10 &&
//                             phonevalidate(value) == null) {
//                           verifyPhoneNumber(value);
//                         }
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                         controller: houseNumberController,
//                         decoration: InputDecoration(
//                           labelText: 'House Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: buildingNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Building Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: streetController,
//                       decoration: InputDecoration(
//                         labelText: 'Street',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: placeController,
//                       decoration: InputDecoration(
//                         labelText: 'Place',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: isMobileVerified ? create : null,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor:
//                             const Color.fromARGB(255, 237, 34, 102),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         textStyle: TextStyle(fontSize: 20),
//                       ),
//                       child: Text('REGISTER'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('Back To Login'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void verifyPhoneNumber(String phoneNumber) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+91$phoneNumber', // Ensure the country code is correct
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         setState(() {
//           isMobileVerified = true;
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error message'),
//               content: Text(e.message ?? 'Verification failed'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Ok'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         showOtpPopup();
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//       },
//     );
//   }

//   void showOtpPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter OTP'),
//           content: TextField(
//             controller: otpController,
//             decoration: InputDecoration(
//               labelText: 'OTP',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 validateOtp();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void validateOtp() async {
//     String enteredOtp = otpController.text;
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: enteredOtp,
//     );

//     try {
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       setState(() {
//         isMobileVerified = true;
//       });
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('Invalid OTP'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void create() async {
//     String user = userNameController.text;
//     String mobile = mobileNumberController.text;
//     String Street = streetController.text;
//     String housenumstr = houseNumberController.text;
//     String building = buildingNameController.text;
//     String place = placeController.text;

//     if (user.isEmpty ||
//         mobile.isEmpty ||
//         Street.isEmpty ||
//         (housenumstr.toString().isEmpty) ||
//         building.isEmpty ||
//         place.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('All fields are required'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     } else if (phonevalidate(mobile.toString()) != null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('Fill mobile number properly'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       int housenum = int.parse(housenumstr);
//       RegisterModel newmodel = RegisterModel(

//         username: user,
//         mobilenumber: mobile,
//         housenumber: housenum,
//         buildingname: building,
//         street: Street,
//         place: place,
//       );
//       await RegisterDatabase().senddata(newmodel);
//       Provider.of<UserProvider>(context, listen: false).setUsername(user);
//       // Provider.of<PhoneNumberProvider>(context, listen: false)
//           // .setPhoneNumber(mobile);

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('isLoggedIn', true);
//       prefs.setString('username', user);

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => Terms(username: user),
//         ),
//       );
//     }
//   }

//   String? phonevalidate(value) {
//     if (value.isEmpty) {
//       return null;
//     } else if (value.length < 10) {
//       return 'Please enter the full number';
//     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//       return 'Enter valid numbers';
//     }
//     return null;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/model/register.dart';
// import 'package:flutter_application_1/screen/terms.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/controller/userprovider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegistrationForm extends StatefulWidget {
//   const RegistrationForm({super.key});

//   @override
//   State<RegistrationForm> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();
//   final TextEditingController houseNumberController = TextEditingController();
//   final TextEditingController buildingNameController = TextEditingController();
//   final TextEditingController streetController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();

//   bool isMobileVerified = false;
//   String verificationId = '';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/img2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 150),
//                     TextFormField(
//                       controller: userNameController,
//                       decoration: InputDecoration(
//                         labelText: 'User Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       validator: phonevalidate,
//                       maxLength: 10,
//                       controller: mobileNumberController,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         labelText: 'Mobile Number',
//                         border: OutlineInputBorder(),
//                         suffixIcon: isMobileVerified
//                             ? Icon(Icons.check, color: Colors.green)
//                             : null,
//                       ),
//                       keyboardType: TextInputType.phone,
//                       onChanged: (value) async {
//                         if (value.length == 10 &&
//                             phonevalidate(value) == null) {
//                           bool exists = await checkIfPhoneExists(value);
//                           if (!exists) {
//                             verifyPhoneNumber(value);
//                           } else {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Error'),
//                                   content:
//                                       Text('Phone number already registered.'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Ok'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           }
//                         }
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                         controller: houseNumberController,
//                         decoration: InputDecoration(
//                           labelText: 'House Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: buildingNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Building Name',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: streetController,
//                       decoration: InputDecoration(
//                         labelText: 'Street',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: placeController,
//                       decoration: InputDecoration(
//                         labelText: 'Place',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: isMobileVerified ? create : null,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor:
//                             const Color.fromARGB(255, 237, 34, 102),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         textStyle: TextStyle(fontSize: 20),
//                       ),
//                       child: Text('REGISTER'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('Back To Login'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool> checkIfPhoneExists(String phoneNumber) async {
//     RegisterDatabase db = RegisterDatabase();
//     var user = await db.getdetails(phoneNumber);
//     return user != null;
//   }

//   void verifyPhoneNumber(String phoneNumber) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+91$phoneNumber', // Ensure the country code is correct
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         setState(() {
//           isMobileVerified = true;
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error message'),
//               content: Text(e.message ?? 'Verification failed'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Ok'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         showOtpPopup();
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         setState(() {
//           this.verificationId = verificationId;
//         });
//       },
//     );
//   }

//   void showOtpPopup() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter OTP'),
//           content: TextField(
//             controller: otpController,
//             decoration: InputDecoration(
//               labelText: 'OTP',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 validateOtp();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void validateOtp() async {
//     String enteredOtp = otpController.text;
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: enteredOtp,
//     );

//     try {
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       setState(() {
//         isMobileVerified = true;
//       });
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('Invalid OTP'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void create() async {
//     String user = userNameController.text;
//     String mobile = mobileNumberController.text;
//     String street = streetController.text;
//     String housenumstr = houseNumberController.text;
//     String building = buildingNameController.text;
//     String place = placeController.text;

//     if (user.isEmpty ||
//         mobile.isEmpty ||
//         street.isEmpty ||
//         housenumstr.isEmpty ||
//         building.isEmpty ||
//         place.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('All fields are required'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     } else if (phonevalidate(mobile) != null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error message'),
//             content: Text('Fill mobile number properly'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       int housenum = int.parse(housenumstr);
//       RegisterModel newmodel = RegisterModel(
//         username: user,
//         mobilenumber: mobile,
//         housenumber: housenum,
//         buildingname: building,
//         street: street,
//         place: place,
//       );
//       await RegisterDatabase().senddata(newmodel);
//       Provider.of<UserProvider>(context, listen: false).setUsername(user);

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('isLoggedIn', true);
//       prefs.setString('username', user);
//       prefs.setString('mobile', mobile);

//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => Terms(username: user,),
//         ),
//       );
//     }
//   }

//   String? phonevalidate(value) {
//     if (value.isEmpty) {
//       return null;
//     } else if (value.length < 10) {
//       return 'Please enter the full number';
//     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//       return 'Enter valid numbers';
//     }
//     return null;
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/screen/terms.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      onChanged: (value) async {
                        print('Mobile number changed: $value'); // Debug print
                        if (value.length == 10 &&
                            phonevalidate(value) == null) {
                          bool exists = await checkIfPhoneExists(value);
                          if (!exists) {
                            verifyPhoneNumber(value);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content:
                                      Text('Phone number already registered.'),
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
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: houseNumberController,
                      decoration: InputDecoration(
                        labelText: 'House Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
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
                        backgroundColor:
                            const Color.fromARGB(255, 237, 34, 102),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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

  Future<bool> checkIfPhoneExists(String phoneNumber) async {
    print('Checking if phone number exists: $phoneNumber'); // Debug print
    RegisterDatabase db = RegisterDatabase();
    var user = await db.getdetails(phoneNumber);
    bool exists = user != null;
    print('Phone number exists: $exists'); // Debug print
    return exists;
  }

  void verifyPhoneNumber(String phoneNumber) async {
    print('Verifying phone number: $phoneNumber'); // Debug print
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('Verification completed'); // Debug print
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          isMobileVerified = true;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}'); // Debug print
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
        print('Code sent: $verificationId'); // Debug print
        setState(() {
          this.verificationId = verificationId;
        });
        showOtpPopup();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Code auto-retrieval timeout: $verificationId'); // Debug print
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
      print('Validating OTP'); // Debug print
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        isMobileVerified = true;
      });
    } catch (e) {
      print('Invalid OTP: $e'); // Debug print
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
    print('Create method called'); // Debug print

    String user = userNameController.text;
    String mobile = mobileNumberController.text;
    String street = streetController.text;
    String housenumstr = houseNumberController.text;
    String building = buildingNameController.text;
    String place = placeController.text;

    if (user.isEmpty ||
        mobile.isEmpty ||
        street.isEmpty ||
        housenumstr.isEmpty ||
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
    } else if (phonevalidate(mobile) != null) {
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
      int housenum;
      try {
        housenum = int.parse(housenumstr);
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error message'),
              content: Text('Invalid house number'),
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
        return;
      }

      RegisterModel newmodel = RegisterModel(
        id: '',
        username: user,
        mobilenumber: mobile,
        housenumber: housenum,
        buildingname: building,
        street: street,
        place: place,
      );

      try {
        await RegisterDatabase().senddata(newmodel);
        Provider.of<UserProvider>(context, listen: false).setUsername(user);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', user);
        await prefs.setString('mobile', mobile);

        print('Stored values:');
        print('isLoggedIn: ${prefs.getBool('isLoggedIn')}');
        print('username: ${prefs.getString('username')}');
        print('mobile: ${prefs.getString('mobile')}');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Terms(
              username: user,
            ),
          ),
        );
      } catch (e) {
        print('Error storing data: $e'); // Debug print
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error message'),
              content: Text('Failed to store registration data'),
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
  }

  String? phonevalidate(value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }
}
