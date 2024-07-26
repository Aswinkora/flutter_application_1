import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _updateExistingDocuments();
  }

  Future<void> _sendMessage(String message, [String imageUrl = '']) async {
    try {
      if (_currentUser != null) {
        print("Sending message: $message");
        await _firestore.collection('community').add({
          'userId': _currentUser!.uid,
          'username': _currentUser!.displayName ?? 'Anonymous',
          'message': message,
          'imageUrl': imageUrl,
          'timestamp': FieldValue.serverTimestamp(),
          'reactions': 0,
        });
        _messageController.clear();
        print("Message sent successfully");
      } else {
        print("Error: No user is logged in.");
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final fileName = basename(pickedFile.path);
        final destination = 'images/$fileName';
        final ref = _storage.ref(destination);
        await ref.putFile(File(pickedFile.path));
        final imageUrl = await ref.getDownloadURL();
        _sendMessage('', imageUrl);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _reactToMessage(DocumentSnapshot doc) async {
    try {
      await _firestore.collection('community').doc(doc.id).update({
        'reactions': FieldValue.increment(1),
      });
    } catch (e) {
      print("Error reacting to message: $e");
    }
  }

  Future<void> _updateExistingDocuments() async {
    try {
      final querySnapshot = await _firestore.collection('community').get();

      for (var doc in querySnapshot.docs) {
        if (!doc.data().containsKey('username')) {
          await doc.reference.update({'username': 'Anonymous'});
        }
      }
    } catch (e) {
      print("Error updating existing documents: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('community').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final userName = data['userName'] ?? 'Anonymous';
                    final imageUrl = data['imageUrl'] ?? '';
                    final message = data['message'] ?? '';
                    final reactions = data['reactions'] ?? 0;

                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
                          if (imageUrl.isNotEmpty)
                            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
                          if (message.isNotEmpty) 
                            Text(message),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            onPressed: () => _reactToMessage(doc),
                          ),
                          Text(reactions.toString()),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: _pickImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
