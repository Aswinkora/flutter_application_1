import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/tabs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/screen/login.dart';

class Terms extends StatelessWidget {
  final String username;

  const Terms({super.key, required this.username, });

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
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  username,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
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
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Text(
                  'Onam is a cultural festival celebrated in Kerala, India. It is also a harvest festival, and falls on the 22nd nakshatra.\n\n'
                  'Terms and Conditions:\n\n'
                  '1. If users abuse your website or mobile app in any way you can terminate their account.\n\n'
                  '2. If users can post content on your website or mobile app you can remove any content they created if it infringes copyright.\n\n'
                  '3. If you sell products or services, you could cancel specific orders if a product price is incorrect.',
                  style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink, Colors.deepPurple],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Tabs(user: username),
                    ));
                  },
                  borderRadius: BorderRadius.circular(25.0),
                  child: Center(
                    child: Text(
                      'START',
                      style: GoogleFonts.aladin(fontSize: 33),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
