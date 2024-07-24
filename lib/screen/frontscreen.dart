import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Frontscreen(),
    );
  }
}

class Frontscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/down1.png'))),
              ),
              Center(
                child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple]),
                        borderRadius: BorderRadius.circular(25)),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(25.0),
                            child: Center(
                              child: Text('Begin'),
                            )))),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}