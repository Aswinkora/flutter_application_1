// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controller/userprovider.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community Chat'),
//         leading: Row(
//           children: [
//             Icon(Icons.person),
//             Flexible(
//               child: Text(userProvider.username, overflow: TextOverflow.clip),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await _auth.signOut();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_chat') // Adjust the collection name as needed
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
//                       trailing: Text(
//                         message['timestamp'] != null
//                             ? (message['timestamp'] as Timestamp).toDate().toString()
//                             : '',
//                         style: TextStyle(fontSize: 10, color: Colors.grey),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Send a message...'),
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

//   void _sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         try {
//           await FirebaseFirestore.instance
//               .collection('community_chat') // Adjust the collection name as needed
//               .add({
//             'text': _messageController.text,
//             'sender': user.email ?? 'Anonymous',
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//           _messageController.clear();
//         } catch (e) {
//           print('Error sending message: $e');
//         }
//       }
//     }
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/model/uploadimage.dart'; // Ensure you have the uploadimage function for image uploads

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Community Chat'),
        leading: Row(
          children: [
            Icon(Icons.person),
            Flexible(
              child: Text(userProvider.username, overflow: TextOverflow.clip),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('community_chat')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['sender']),
                      subtitle: message['imageUrl'] != null
                          ? Image.network(message['imageUrl'])
                          : Text(message['text']),
                      trailing: Text(
                        message['timestamp'] != null
                            ? (message['timestamp'] as Timestamp).toDate().toString()
                            : '',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (_isUploading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Send a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        await FirebaseFirestore.instance.collection('community_chat').add({
          'text': _messageController.text,
          'sender': userProvider.username,
          'timestamp': FieldValue.serverTimestamp(),
          'imageUrl': null,
        });
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      _uploadImage(image);
    }
  }

  void _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl = await uploadimage(image);
      if (imageUrl != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await FirebaseFirestore.instance.collection('community_chat').add({
          'text': null,
          'sender': userProvider.username,
          'timestamp': FieldValue.serverTimestamp(),
          'imageUrl': imageUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload successful!')),
        );
      } else {
        throw Exception('Image upload failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }
}
