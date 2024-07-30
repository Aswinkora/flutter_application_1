import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientProvider with ChangeNotifier {
  List<DocumentSnapshot> _items = [];
  List<DocumentSnapshot> _filteredItems = [];
  bool _isLoading = false;

  List<DocumentSnapshot> get items => _filteredItems;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    Future.microtask(() {
      _isLoading = true;
    notifyListeners();

    });
    
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('items').get();
      _items = snapshot.docs;
      _filteredItems = _items;
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      _filteredItems = _items;
    } else {
      _filteredItems = _items.where((item) {
        return item['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
