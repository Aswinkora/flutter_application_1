import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/image.dart';

class Days extends StatefulWidget {
  const Days({super.key});

  @override
  State<Days> createState() => _DaysState();
}

class _DaysState extends State<Days> {
  List list = [
    'ATHAM',
    'CHITHiRA',
    'CHODHI',
    'VISHAKAM',
    'ANIZHAM',
    'THRIKETA',
    'MOOLAM',
    'POORADAM',
    'UTHRADAM',
    'THIRUVONAM'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Imagescreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 246, 106, 153),
                          Colors.purpleAccent
                        ])),
                        child: Center(
                          child: ListTile(
                            leading: Text(list[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
