import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassSch extends StatelessWidget {
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Class Schedule'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: eventsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final events = snapshot.data!.docs.map((doc) => doc.data()).toList();
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final startTime = (event as Map)['startTime'].toDate();
              final endTime = event['endTime'].toDate();
              final now = DateTime.now();

              String status = 'upcoming';
              if (now.isAfter(startTime) && now.isBefore(endTime)) {
                status = 'on going';
              } else if (now.isAfter(endTime)) {
                status = 'finished';
              }
              return Card(
                child: ListTile(
                  title: Text(event['name']),
                  subtitle: Text('Classroom- ${event['location']}'),
                  trailing: Text('$status',
                      style: TextStyle(
                          // color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
