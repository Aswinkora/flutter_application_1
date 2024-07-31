// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controller/userprovider.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_application_1/model/uploadimage.dart'; // Ensure you have the uploadimage function for image uploads

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final ImagePicker _picker = ImagePicker();
//   bool _isUploading = false;

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.person),
//             SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 userProvider.username,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('community_chat')
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
//                     bool isMe = message['sender'] == userProvider.username;
//                     Map<String, dynamic>? reactions = (message.data() as Map<String, dynamic>)['reactions'] as Map<String, dynamic>?;

//                     return GestureDetector(
//                       onLongPress: () {
//                         _showReactionOptions(message.id, userProvider.username);
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                         child: Container(
//                           constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: isMe ? Colors.blue[100] : Colors.grey[300],
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                                 children: [
//                                   if (isMe)
//                                     IconButton(
//                                       icon: Icon(Icons.delete, color: Colors.red),
//                                       onPressed: () {
//                                         _deleteMessage(message.id);
//                                       },
//                                     ),
//                                   Text(
//                                     message['sender'],
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: isMe ? Colors.blue : Colors.grey[700],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                               message['imageUrl'] != null
//                                   ? Image.network(message['imageUrl'])
//                                   : Text(message['text']),
//                               SizedBox(height: 5),
//                               Text(
//                                 message['timestamp'] != null
//                                     ? (message['timestamp'] as Timestamp).toDate().toString()
//                                     : '',
//                                 style: TextStyle(fontSize: 10, color: Colors.grey),
//                               ),
//                               SizedBox(height: 5),
//                               _buildReactions(reactions),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           if (_isUploading) CircularProgressIndicator(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.photo),
//                   onPressed: _pickImage,
//                 ),
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
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       try {
//         await FirebaseFirestore.instance.collection('community_chat').add({
//           'text': _messageController.text,
//           'sender': userProvider.username,
//           'timestamp': FieldValue.serverTimestamp(),
//           'imageUrl': null,
//           'reactions': {},
//         });
//         _messageController.clear();
//       } catch (e) {
//         print('Error sending message: $e');
//       }
//     }
//   }

//   void _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File image = File(pickedFile.path);
//       _uploadImage(image);
//     }
//   }

//   void _uploadImage(File image) async {
//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       String? imageUrl = await uploadimage(image);
//       if (imageUrl != null) {
//         final userProvider = Provider.of<UserProvider>(context, listen: false);
//         await FirebaseFirestore.instance.collection('community_chat').add({
//           'text': null,
//           'sender': userProvider.username,
//           'timestamp': FieldValue.serverTimestamp(),
//           'imageUrl': imageUrl,
//           'reactions': {},
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Image upload successful!')),
//         );
//       } else {
//         throw Exception('Image upload failed');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }

//   void _showReactionOptions(String messageId, String username) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.thumb_up),
//                 title: Text('Like'),
//                 onTap: () {
//                   _addReaction(messageId, 'like', username);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.favorite),
//                 title: Text('Love'),
//                 onTap: () {
//                   _addReaction(messageId, 'love', username);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               // Add more reactions here if needed
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _addReaction(String messageId, String reactionType, String username) async {
//     DocumentReference messageRef = FirebaseFirestore.instance.collection('community_chat').doc(messageId);

//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot messageSnapshot = await transaction.get(messageRef);
//       if (!messageSnapshot.exists) {
//         throw Exception("Message does not exist!");
//       }

//       Map<String, dynamic> messageData = messageSnapshot.data() as Map<String, dynamic>;
//       Map<String, dynamic> reactions = messageData['reactions'] ?? {};
//       List<dynamic> reactionUsers = reactions[reactionType] ?? [];

//       if (reactionUsers.contains(username)) {
//         reactionUsers.remove(username);
//       } else {
//         reactionUsers.add(username);
//       }

//       reactions[reactionType] = reactionUsers;

//       transaction.update(messageRef, {'reactions': reactions});
//     });
//   }

//   void _deleteMessage(String messageId) async {
//     try {
//       await FirebaseFirestore.instance.collection('community_chat').doc(messageId).delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Message deleted')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to delete message: $e')),
//       );
//     }
//   }

//   Widget _buildReactions(Map<String, dynamic>? reactions) {
//     if (reactions == null || reactions.isEmpty) return Container();

//     List<Widget> reactionWidgets = [];
//     reactions.forEach((reactionType, users) {
//       if (users.isNotEmpty) {
//         reactionWidgets.add(Row(
//           children: [
//             Icon(
//               reactionType == 'like' ? Icons.thumb_up : Icons.favorite,
//               size: 16,
//             ),
//             SizedBox(width: 4),
//             Text(users.length.toString()),
//           ],
//         ));
//       }
//     });

//     return Row(children: reactionWidgets);
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
  bool _chatEnabled = false;

  @override
  void initState() {
    super.initState();
    _fetchChatStatus();
  }

  Future<void> _fetchChatStatus() async {
    DocumentSnapshot chatStatusDoc = await FirebaseFirestore.instance
        .collection('admin_settings')
        .doc('chat_status')
        .get();
    if (chatStatusDoc.exists) {
      setState(() {
        _chatEnabled = chatStatusDoc['enabled'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                userProvider.username,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
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
                    bool isMe = message['sender'] == userProvider.username;
                    Map<String, dynamic>? reactions = (message.data() as Map<String, dynamic>)['reactions'] as Map<String, dynamic>?;

                    return GestureDetector(
                      onLongPress: () {
                        _showReactionOptions(message.id, userProvider.username);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                children: [
                                  if (isMe)
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _deleteMessage(message.id);
                                      },
                                    ),
                                  Text(
                                    message['sender'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isMe ? Colors.blue : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              message['imageUrl'] != null
                                  ? Image.network(message['imageUrl'])
                                  : Text(message['text']),
                              SizedBox(height: 5),
                              Text(
                                message['timestamp'] != null
                                    ? (message['timestamp'] as Timestamp).toDate().toString()
                                    : '',
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              _buildReactions(reactions),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (_isUploading) CircularProgressIndicator(),
          if (_chatEnabled)
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
          if (!_chatEnabled)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Chat is disabled by the admin',
                style: TextStyle(color: Colors.red, fontSize: 16),
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
          'reactions': {},
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
          'reactions': {},
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

  void _showReactionOptions(String messageId, String username) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.thumb_up),
                title: Text('Like'),
                onTap: () {
                  _addReaction(messageId, 'like', username);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Love'),
                onTap: () {
                  _addReaction(messageId, 'love', username);
                  Navigator.of(context).pop();
                },
              ),
              // Add more reactions here if needed
            ],
          ),
        );
      },
    );
  }

  void _addReaction(String messageId, String reactionType, String username) async {
    DocumentReference messageRef = FirebaseFirestore.instance.collection('community_chat').doc(messageId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot messageSnapshot = await transaction.get(messageRef);
      if (!messageSnapshot.exists) {
        throw Exception("Message does not exist!");
      }

      Map<String, dynamic> messageData = messageSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> reactions = messageData['reactions'] ?? {};
      List<dynamic> reactionUsers = reactions[reactionType] ?? [];

      if (reactionUsers.contains(username)) {
        reactionUsers.remove(username);
      } else {
        reactionUsers.add(username);
      }

      reactions[reactionType] = reactionUsers;

      transaction.update(messageRef, {'reactions': reactions});
    });
  }

  void _deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance.collection('community_chat').doc(messageId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete message: $e')),
      );
    }
  }

  Widget _buildReactions(Map<String, dynamic>? reactions) {
    if (reactions == null || reactions.isEmpty) return Container();

    List<Widget> reactionWidgets = [];
    reactions.forEach((reactionType, users) {
      if (users.isNotEmpty) {
        reactionWidgets.add(Row(
          children: [
            Icon(
              reactionType == 'like' ? Icons.thumb_up : Icons.favorite,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(users.length.toString()),
          ],
        ));
      }
    });

    return Row(children: reactionWidgets);
  }
}
