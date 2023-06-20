import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClassSch extends StatefulWidget {
  @override
  State<ClassSch> createState() => _ClassSchState();
}

class _ClassSchState extends State<ClassSch> {
  Stream<QuerySnapshot<Map<String, dynamic>>> classes() async* {
    yield* FirebaseFirestore.instance.collection('Classes').snapshots();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2ECC71),
        title: Text('Class Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: classes(),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    if (docs.length == 0) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (_, index) {
                            final startTime = docs[index]['startTime'].toDate();
                            final endTime = docs[index]['endTime'].toDate();
                            final now = DateTime.now();
                            DateFormat time = DateFormat('h:mm a');

                            String sTime = time.format(startTime);
                            String eTime = time.format(endTime);

                            String status = 'COMMING at ${sTime}';
                            Color color = Colors.yellow;
                            if (now.isAfter(startTime) &&
                                now.isBefore(endTime)) {
                              status = 'ON GOING';
                              color = Colors.green;
                            } else if (now.isAfter(endTime)) {
                              status = 'FINISHED';
                              color = Colors.red;
                            }
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xFFEAECEE),
                                  // backgroundImage:
                                  //     NetworkImage(docs[index]['img_url']),
                                  child: Image.asset(
                                    'assets/icons/lecture.png',
                                    height: 35,
                                  ),
                                ),
                                title: Text(docs[index]['name']),
                                subtitle: Text(
                                    '${docs[index]['location']} \(${sTime} \- $eTime\)'),
                                trailing: Text('$status',
                                    style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                              ),
                            );
                          });
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }))),
      ),
    );
  }
}
