import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/tabs.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatelessWidget {
  final String username;

  const Terms({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/img2.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: SingleChildScrollView(
            child: Row(
              children: [
                Icon(Icons.person),SizedBox(width: 10,),
                Flexible(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(username,overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    '916 ONAM',
                    style: GoogleFonts.bungeeShade(
                        fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ],
              ),
            ),
            Container(
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
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Tabs(user: username,)));
                        },
                        borderRadius: BorderRadius.circular(25.0),
                        child: Center(
                          child: Text(
                            'START',
                            style: GoogleFonts.aladin(fontSize: 33),
                          ),
                        ))))
          ],
        ),
      ),
    );
  }
}
