import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/provider.dart';

class ClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Client Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: "search",
                // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(15),
                ),
                // filled: true,
                // fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color.fromARGB(221, 166, 165, 165),
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Color.fromARGB(221, 166, 165, 165)),
              ),
              style: TextStyle(color: Colors.black), // Ensure the text is visible
              onChanged: (value) {
                clientProvider.filterItems(value);
              },
            ),
          ),
          Expanded(
            child: clientProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : clientProvider.items.isEmpty
                    ? Center(child: Text('No items found'))
                    : ListView.builder(
                        itemCount: clientProvider.items.length,
                        itemBuilder: (context, index) {
                          var doc = clientProvider.items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        doc['imageUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            doc['description'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹${doc['originalPrice']}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Text(
                                                '50%',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => clientProvider.fetchItems(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
