// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screen/image.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Days extends StatefulWidget {
//   const Days({super.key});

//   @override
//   State<Days> createState() => _DaysState();
// }

// class _DaysState extends State<Days> {
//   List list = [
//     'ATHAM',
//     'CHITHIRA',
//     'CHODHI',
//     'VISHAKAM',
//     'ANIZHAM',
//     'THRIKETA',
//     'MOOLAM',
//     'POORADAM',
//     'UTHRADAM',
//     'THIRUVONAM'
//   ];
//   List<DateTime> date = [
//     DateTime(2024, 07, 23),
//     DateTime(2024, 07, 22),
//     DateTime(2024, 07, 24),
//     DateTime(2024, 07, 25),
//     DateTime(2024, 07, 26),
//     DateTime(2024, 07, 27),
//     DateTime(2024, 07, 28),
//     DateTime(2024, 07, 29),
//     DateTime(2024, 07, 31),
//     DateTime(2024, 08, 01),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(

//       ),
//       body: Container(
//         color: Colors.transparent,
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (context, index) {
//                   DateTime datetime = date[index];
//                   DateTime today = DateTime.now();
//                   bool current = today.year == datetime.year &&
//                       today.month == datetime.month &&
//                       today.day == datetime.day;

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         if (current) {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => Imagescreen()));
//                         } else
//                           (ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('NOT ALLOWEDED'))));
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(33),
//                             gradient: LinearGradient(
//                                 colors: current
//                                     ? [
//                                         // Color.fromARGB(130, 228, 6, 248),
//                                         // Color.fromARGB(223, 133, 2, 145)
//                                         Color.fromARGB(255, 255, 215, 0),
//                                         Color.fromARGB(255, 255, 223, 186),
//                                       ]
//                                     : [
//                                         Color.fromARGB(117, 255, 217, 0),
//                                         Color.fromARGB(255, 255, 223, 186),
//                                       ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.bottomLeft)),
//                         child: Center(
//                           child: ListTile(
//                             leading: Text(
//                               list[index],
//                               style: GoogleFonts.inter(fontSize: 20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
//             label: 'HOME',
//           ),
//           BottomNavigationBarItem(
//             icon: IconButton(onPressed: () {}, icon: Icon(Icons.local_offer)),
//             label: 'OFFERS',
//           ),
//           BottomNavigationBarItem(
//             icon: IconButton(onPressed: () {}, icon: Icon(Icons.people)),
//             label: 'COMMUNITY',
//           ),
//         ],
//       ),
//     );
//   }
// }
//  ------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_application_1/screen/image.dart';

// class Days extends StatefulWidget {
//   const Days({super.key});

//   @override
//   State<Days> createState() => _DaysState();
// }

// class _DaysState extends State<Days> {
//   List<String> list = [
//     'ATHAM',
//     'CHITHIRA',
//     'CHODHI',
//     'VISHAKAM',
//     'ANIZHAM',
//     'THRIKETA',
//     'MOOLAM',
//     'POORADAM',
//     'UTHRADAM',
//     'THIRUVONAM'
//   ];
//   List<DateTime> date = [
//     DateTime(2024, 07, 23),
//     DateTime(2024, 07, 22),
//     DateTime(2024, 07, 24),
//     DateTime(2024, 07, 25),
//     DateTime(2024, 07, 26),
//     DateTime(2024, 07, 27),
//     DateTime(2024, 07, 28),
//     DateTime(2024, 07, 29),
//     DateTime(2024, 07, 31),
//     DateTime(2024, 08, 01),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Day'),
//       ),
//       body: Container(
//         color: Colors.transparent,
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: list.length,
//                 itemBuilder: (context, index) {
//                   DateTime datetime = date[index];
//                   DateTime today = DateTime.now();
//                   bool current = today.year == datetime.year &&
//                       today.month == datetime.month &&
//                       today.day == datetime.day;

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         if (current) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => Imagescreen(
//                                 selectedDate: datetime,
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('NOT ALLOWED')),
//                           );
//                         }
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(33),
//                           gradient: LinearGradient(
//                             colors: current
//                                 ? [
//                                     Color.fromARGB(255, 255, 215, 0),
//                                     Color.fromARGB(255, 255, 223, 186),
//                                   ]
//                                 : [
//                                     Color.fromARGB(117, 255, 217, 0),
//                                     Color.fromARGB(255, 255, 223, 186),
//                                   ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.bottomLeft,
//                           ),
//                         ),
//                         child: Center(
//                           child: ListTile(
//                             leading: Text(
//                               list[index],
//                               style: GoogleFonts.inter(fontSize: 20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_1/screen/image.dart';

// class Days extends StatefulWidget {
//   const Days({super.key});

//   @override
//   State<Days> createState() => _DaysState();
// }

// class _DaysState extends State<Days> {
//   DateTime? _baseDate;
//   List<String> _days = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchSettings();
//   }

//   Future<void> _fetchSettings() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('days')
//           .doc('settings')
//           .get();

//       if (snapshot.exists) {
//         Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//         if (data != null) {
//           setState(() {
//             _baseDate = (data['baseDate'] as Timestamp?)?.toDate();
//             _days = List<String>.from(data['days'] ?? []);
//           });
//         } else {
//           _showError('No data found');
//         }
//       } else {
//         _showError('Document does not exist');
//       }
//     } catch (e) {
//       _showError('Error fetching settings: $e');
//     }
//   }

//   String? _calculateCurrentDay() {
//     if (_baseDate == null || _days.isEmpty) return null;
//     int dayIndex =
//         ((DateTime.timestamp().difference(_baseDate!).inDays) % _days.length);
//     return _days[dayIndex];
//   }

//   bool _isCurrentDay(String dayName) {
//     if (_baseDate == null) return false;
//     int dayIndex = _days.indexOf(dayName);
//     DateTime startDate = _baseDate!.add(Duration(days: dayIndex));
//     DateTime endDate = startDate.add(Duration(hours: 24));
//     DateTime now = DateTime.timestamp();
//     return now.isAfter(startDate) && now.isBefore(endDate);
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Day'),
//       ),
//       body: Container(
//         color: Colors.transparent,
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _days.length,
//                 itemBuilder: (context, index) {
//                   String dayName = _days[index];
//                   bool current = _isCurrentDay(dayName);

//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         if (current) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => Imagescreen(
//                                 selectedDate: DateTime.timestamp(),
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('NOT ALLOWED')),
//                           );
//                         }
//                       },
//                       child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(33),
//                           gradient: LinearGradient(
//                             colors: current
//                                 ? [
//                                     Color.fromARGB(255, 255, 215, 0),
//                                     Color.fromARGB(255, 255, 223, 186),
//                                   ]
//                                 : [
//                                     Color.fromARGB(117, 255, 217, 0),
//                                     Color.fromARGB(255, 255, 223, 186),
//                                   ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.bottomLeft,
//                           ),
//                         ),
//                         child: Center(
//                           child: ListTile(
//                             leading: Text(
//                               dayName,
//                               style: GoogleFonts.inter(fontSize: 20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/screen/image.dart';

class Days extends StatefulWidget {
  const Days({super.key});

  @override
  State<Days> createState() => _DaysState();
}

class _DaysState extends State<Days> {
  DateTime? _baseDate;
  List<String> _days = [];
  DateTime? _serverDate;

  @override
  void initState() {
    super.initState();
    _fetchSettings();
  }

  Future<void> _fetchSettings() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('days')
          .doc('settings')
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            _baseDate = (data['baseDate'] as Timestamp?)?.toDate();
            _days = List<String>.from(data['days'] ?? []);
          });
          _fetchServerDate();
        } else {
          _showError('No data found');
        }
      } else {
        _showError('Document does not exist');
      }
    } catch (e) {
      _showError('Error fetching settings: $e');
    }
  }

  Future<void> _fetchServerDate() async {
    try {
      DocumentReference serverTimestampDoc = FirebaseFirestore.instance
          .collection('serverTime')
          .doc('currentTime');
      await serverTimestampDoc.set({
        'timestamp': FieldValue.serverTimestamp(),
      });

      DocumentSnapshot serverTimestampSnapshot = await serverTimestampDoc.get();
      Timestamp? timestamp = serverTimestampSnapshot['timestamp'] as Timestamp?;
      setState(() {
        _serverDate = timestamp?.toDate();
      });
    } catch (e) {
      _showError('Error fetching server date: $e');
    }
  }

  String? _calculateCurrentDay() {
    if (_baseDate == null || _days.isEmpty || _serverDate == null) return null;
    int dayIndex =
        ((_serverDate!.difference(_baseDate!).inDays) % _days.length);
    return _days[dayIndex];
  }

  bool _isCurrentDay(String dayName) {
    if (_baseDate == null || _serverDate == null) return false;
    int dayIndex = _days.indexOf(dayName);
    DateTime startDate = _baseDate!.add(Duration(days: dayIndex));
    DateTime endDate = startDate.add(Duration(hours: 24));
    DateTime now = _serverDate!;
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
   
        leading: Row(
          children: [
            Icon(Icons.person),
            Flexible(
              child: Text(userProvider.username, overflow: TextOverflow.clip),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  String dayName = _days[index];
                  bool current = _isCurrentDay(dayName);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (current) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Imagescreen(
                                selectedDate: DateTime.now(),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('NOT ALLOWED')),
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          gradient: LinearGradient(
                            colors: current
                                ? [
                                    Color.fromARGB(255, 255, 215, 0),
                                    Color.fromARGB(255, 255, 223, 186),
                                  ]
                                : [
                                    Color.fromARGB(117, 255, 217, 0),
                                    Color.fromARGB(255, 255, 223, 186),
                                  ],
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            leading: Text(
                              dayName,
                              style: GoogleFonts.inter(fontSize: 20),
                            ),
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
