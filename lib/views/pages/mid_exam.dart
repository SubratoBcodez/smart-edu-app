import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class MidExam extends StatefulWidget {
  const MidExam({super.key});

  @override
  State<MidExam> createState() => _MidExamState();
}

class _MidExamState extends State<MidExam> {
  final box = GetStorage();
  String? uid;
  String? email;
  Stream<QuerySnapshot<Map<String, dynamic>>> MidExam() async* {
    yield* FirebaseFirestore.instance.collection('events').snapshots();
  }

  @override
  void initState() {
    uid = box.read('uid');
    email = box.read('email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mid Exam'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: MidExam(),
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

                            DateFormat date = DateFormat.yMMMMd();
                            String sDate = date.format(startTime);
                            String sTime = time.format(startTime);
                            String eTime = time.format(endTime);

                            String status = 'COMMING on ${sDate}';
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
                                  // backgroundImage:
                                  //     NetworkImage(docs[index]['img_url']),
                                  child: Icon(Icons.book_sharp),
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
