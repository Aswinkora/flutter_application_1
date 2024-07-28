import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/community.dart';
import 'package:flutter_application_1/screen/days.dart';
import 'package:flutter_application_1/screen/homescr.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: tabController,
          children: [
            Days(),
            ClientScreen(),
            ChatScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'HOME'),
            Tab(icon: Icon(Icons.local_offer), text: 'OFFERS'),
            Tab(icon: Icon(Icons.people), text: 'COMMUNITY'),
          ],
        ));
  }
}
