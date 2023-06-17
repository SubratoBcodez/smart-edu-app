import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled5/custom/route.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];

  bool notice = false;
  bool user = false;
  String? fname;
  String? idnum;
  String? email;
  fetchNoticeData() {
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
        notice = true;
      });
    });
  }

  @override
  void initState() {
    fetchNoticeData();
    fname = box.read('fname');
    idnum = box.read('idnum');
    email = box.read('email');
    super.initState();
  }

  final box = GetStorage();

  List menu = [
    {
      'title': 'Profile',
      'icon': 'assets/icons/student.png',
      'route': 'account'
    },
    {
      'title': 'Subjects',
      'icon': 'assets/icons/training.png',
      'route': 'subjects'
    },
    {
      'title': 'Exam Schedule',
      'icon': 'assets/icons/exam.png',
      'route': 'exam_nav'
    },
    {
      'title': 'Class Schedule',
      'icon': 'assets/icons/seminar.png',
      'route': 'classes'
    },
    {'title': 'Notice', 'icon': 'assets/icons/notice.png', 'route': 'notice'},
    {'title': 'Developers', 'icon': 'assets/icons/about.png', 'route': 'about'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $fname',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'ID : $idnum ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person_outlined),
                  )
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.green,
                height: 40,
              ),
              SizedBox(
                height: 150,
                child: Container(
                  child: Visibility(
                    visible: notice,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.toNamed(notpage,
                                          arguments: data[index]);
                                    },
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: data[index]['img_url'][0],
                                        key: UniqueKey(),
                                        width: double.maxFinite,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Positioned(
                                  bottom: 5,
                                  left: 10,
                                  right: 10,
                                  child: Text(
                                    data[index]['title'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.green,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.0),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                menu[index]['icon'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                              Text(
                                menu[index]['title'],
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(menu[index]['route']),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )));
  }
}
