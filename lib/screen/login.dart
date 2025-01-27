// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/register.dart';
// import 'package:flutter_application_1/screen/registerform.dart';
// import 'package:flutter_application_1/screen/terms.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/controller/userprovider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController numcntrl = TextEditingController();

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
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: numcntrl,
//                       decoration: InputDecoration(
//                         labelText: 'Mobile Number',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(23),
//                         ),
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           child: Text('Create Account'),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => RegistrationForm(),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: login,
//                         child: Text('Login'),
//                       ),
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

//   void login() async {
//     String mobileNumber = numcntrl.text.trim();
//     RegisterDatabase db = RegisterDatabase();
//     RegisterModel? user = await db.getdetails(mobileNumber);
//     if (user != null) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool('isLoggedIn', true);
//       prefs.setString('username', user.username);
//       prefs.setString('mobile', mobileNumber);

//       Provider.of<UserProvider>(context, listen: false)
//           .setUsername(user.username);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Terms(username: user.username),
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Mobile number not registered'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Ok'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/screen/registerform.dart';
import 'package:flutter_application_1/screen/terms.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController numcntrl = TextEditingController();

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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: numcntrl,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text('Create Account'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationForm(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: login,
                        child: Text('Login'),
                      ),
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

  // void login() async {
  //   String mobileNumber = numcntrl.text.trim();
  //   RegisterDatabase db = RegisterDatabase();
  //   RegisterModel? user = await db.getdetails(mobileNumber);
  //   if (user != null) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('isLoggedIn', true);
  //     prefs.setString('username', user.username);
  //     prefs.setString('mobile', mobileNumber);

  //     Provider.of<UserProvider>(context, listen: false)
  //         .setUsername(user.username);
  //     Provider.of<UserProvider>(context, listen: false)
  //         .setPhoneNumber(mobileNumber);
      
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Terms(username: user.username,),
  //       ),
  //     );
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Mobile number not registered'),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: Text('Ok'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  void login() async {
  String mobileNumber = numcntrl.text.trim();
  RegisterDatabase db = RegisterDatabase();
  RegisterModel? user = await db.getdetails(mobileNumber);
  if (user != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', user.username);
    await prefs.setString('mobile', mobileNumber);

    // Debug print to confirm values
    String? storedUsername = prefs.getString('username');
    String? storedMobile = prefs.getString('mobile');
    print('Stored Username: $storedUsername'); // Debug print
    print('Stored Mobile Number: $storedMobile'); // Debug print

    Provider.of<UserProvider>(context, listen: false)
        .setUsername(user.username);
    Provider.of<UserProvider>(context, listen: false)
        .setPhoneNumber(mobileNumber);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Terms(username: user.username,),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Mobile number not registered'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

}
