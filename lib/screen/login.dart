import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/registerform.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/backgrnd.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Positioned(
            //     right: 40,
            //     left: 0,
            //     child: Image.asset(
            //       'images/img.png',
            //       fit: BoxFit.fill,
            //     )),
            // Positioned.fill(
            //   child: Image.asset(
            // 'images/img.png',
            // fit: BoxFit.fill,
            // )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mobilenumber',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextButton(
                        child: Text('Create Account'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationForm()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
