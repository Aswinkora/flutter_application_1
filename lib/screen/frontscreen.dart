import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/terms.dart';
import 'package:flutter_application_1/controller/userprovider.dart';

class Frontscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkLoginStatus(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/down1.png')),
                  ),
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.pink, Colors.deepPurple]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                        },
                        borderRadius: BorderRadius.circular(25.0),
                        child: Center(
                          child: Text('Begin'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      String username = prefs.getString('username') ?? '';
      Provider.of<UserProvider>(context, listen: false).setUsername(username);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Terms(username: username)));
    }
  }
}
