import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
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
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '916ONAM',
                style: GoogleFonts.bungeeShade(
                  fontSize: 46,
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/down1.png'))),
              ),
              SizedBox(
                height: 100,
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
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Login()));
                            },
                            borderRadius: BorderRadius.circular(25.0),
                            child: Center(
                              child: Text(
                                'Begin',
                                style: GoogleFonts.aladin(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal),
                              ),
                            )))),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
