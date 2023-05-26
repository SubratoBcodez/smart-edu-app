import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../custom/style.dart';

class Exam extends StatefulWidget {
  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> with SingleTickerProviderStateMixin {
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('exams');

  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Exam Schedule'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorWeight: 3,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          controller: _tabController,
          tabs: [
            Tab(
              text: "Mid-Term",
            ),
            Tab(text: 'Final'),
            Tab(text: 'Make-up'),
          ],
        ),
      ),
      body: TabBarView(
        viewportFraction: 1.0,
        controller: _tabController,
        children: [
          Center(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                " Mid Term",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Divider(
                thickness: 2,
                color: Colors.green,
              )
            ],
          )),
          Center(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "  Final",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Divider(
                thickness: 2,
                color: Colors.green,
              )
            ],
          )),
          Center(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "  Make-up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Divider(
                thickness: 2,
                color: Colors.green,
              )
            ],
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
