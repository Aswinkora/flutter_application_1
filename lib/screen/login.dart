import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/register.dart';
import 'package:flutter_application_1/screen/days.dart';
import 'package:flutter_application_1/screen/registerform.dart';

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
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: login,
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
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

  void login() async {
    String mobileNumber = numcntrl.text.trim();
    RegisterDatabase db = RegisterDatabase();
    RegisterModel? user = await db.getdetails(mobileNumber);
    if (user != null) {
      print('User found: ${user.username}');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Days()));
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
