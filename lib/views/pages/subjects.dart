import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final box = GetStorage();
  String? uid;
  String? email;

  Stream<QuerySnapshot<Map<String, dynamic>>> Subjects() async* {
    yield* FirebaseFirestore.instance.collection('Subject').snapshots();
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
        backgroundColor: Colors.green,
        title: Text('Subjects'),
        centerTitle: true,
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: Subjects(),
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
                          return Card(
                            child: ListTile(
                              title: Text(
                                docs[index]['course'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                docs[index]['teacher'],
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                // backgroundImage:
                                //     NetworkImage(docs[index]['img_url']),
                                child: Icon(Icons.book_sharp),
                              ),
                              trailing: Text(
                                docs[index]['classroom'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),

                              // trailing: IconButton(
                              //     onPressed: () => delFav(docs[index].id),
                              //     icon: Icon(
                              //       Icons.remove_circle_outline,
                              //       color: Colors.red,
                              //     )),
                            ),
                          );
                        });
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }))),
    );
  }
}
