import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/custom/route.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List data = [];

  bool value = false;

  fetchData() {
    FirebaseFirestore.instance
        .collection('notice')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        data.add({
          'title': element['title'],
          'date': element['date'],
          'img_url': element['img_url'],
          'document_id': element.id,
        });
      });
      setState(() {
        value = true;
      });
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2ECC71),
        title: Text(
          'Notice',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Container(
          child: Visibility(
            visible: value,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.toNamed(notpage, arguments: data[index]);
                            },
                            splashColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: data[index]['img_url'][0],
                                key: UniqueKey(),
                                height: 200,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Card(
                            child: ListTile(
                              tileColor: Colors.transparent,
                              title: Text(
                                data[index]['title'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                data[index]['date'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
