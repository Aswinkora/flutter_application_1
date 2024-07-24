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
//     'CHITHiRA',
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
//     DateTime(2024, 07, 24),
//     DateTime(2024, 07, 25),
//     DateTime(2024, 07, 26),
//     DateTime(2024, 07, 27),
//     DateTime(2024, 07, 28),
//     DateTime(2024, 07, 29),
//     DateTime(2024, 07, 30),
//     DateTime(2024, 07, 31),
//     DateTime(2024, 08, 01),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//     );
//   }
// }
