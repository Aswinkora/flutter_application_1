// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/firebase_options.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AuthenticationWrapper(),
//     );
//   }
// }






// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasData) {
//           return HomePage();
//         }
//         return LoginPage();
//       },
//     );
//   }
// }



// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLogin = true;

//   void _toggleFormType() {
//     setState(() {
//       _isLogin = !_isLogin;
//     });
//   }

//   void _submit() async {
//     try {
//       if (_isLogin) {
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );
//       } else {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );
//       }
//     } catch (e) {
//       print(e); // Handle error appropriately
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submit,
//               child: Text(_isLogin ? 'Login' : 'Register'),
//             ),
//             TextButton(
//               onPressed: _toggleFormType,
//               child: Text(_isLogin ? 'Create an account' : 'Have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class ChatPage extends StatefulWidget {
//   final String groupId;

//   ChatPage({required this.groupId});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void _sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         await FirebaseFirestore.instance
//             .collection('groups')
//             .doc(widget.groupId)
//             .collection('messages')
//             .add({
//           'text': _messageController.text,
//           'sender': user.displayName ?? user.email,
//           'timestamp': FieldValue.serverTimestamp(),
//         });
//         _messageController.clear();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('groups')
//                   .doc(widget.groupId)
//                   .collection('messages')
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 var messages = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//                     return ListTile(
//                       title: Text(message['sender']),
//                       subtitle: Text(message['text']),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(labelText: 'Send a message...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community Chat'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AdminPage()),
//                 );
//               },
//               child: Text('Admin Page'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Example groupId; this should be dynamically fetched from created groups
//                 String groupId = 'exampleGroupId';
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ChatPage(groupId: groupId)),
//                 );
//               },
//               child: Text('Chat Page'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class AdminPage extends StatefulWidget {
//   @override
//   _AdminPageState createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   final TextEditingController _groupController = TextEditingController();

//   void _createGroup() {
//     if (_groupController.text.isNotEmpty) {
//       FirebaseFirestore.instance.collection('groups').add({
//         'name': _groupController.text,
//       });
//       _groupController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin - Create Groups')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _createGroup,
//               child: Text('Create Group'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

