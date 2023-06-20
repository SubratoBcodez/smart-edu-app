import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled5/custom/route.dart';
import 'package:untitled5/views/pages/exam.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];

  bool notice = false;
  bool user = false;

  final box = GetStorage();

  String? fname;
  String? idnum;
  String? email;
  String? _uid;

  String? _fname;
  String? _idnum;

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

  final CollectionReference slidesCollection =
      FirebaseFirestore.instance.collection('slides');

  @override
  void initState() {
    fetchNoticeData();
    idnum = box.read('idnum');
    email = box.read('email');
    _uid = box.read('_uid');

    print(_uid);

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((msg) {
      if (msg.notification != null) {
        print(msg.notification!.title);
        print(msg.notification!.body);
      }
    });

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (msg.notification != null) {
        print(msg.notification!.title);
        print(msg.notification!.body);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      if (msg != null) {
        print(msg.notification!.title);
        print(msg.notification!.body);
      }
    });
    super.initState();
  }

  List menu = [
    {'title': 'Profile', 'icon': 'assets/icons/student.png', 'route': 'exam'},
    {
      'title': 'Subjects',
      'icon': 'assets/icons/stack-of-books.png',
      'route': 'subjects'
    },
    {
      'title': 'Exam Schedule',
      'icon': 'assets/icons/exam.png',
      'route': 'exam_nav'
    },
    {
      'title': 'Class Schedule',
      'icon': 'assets/icons/class.png',
      'route': 'classes'
    },
    {'title': 'Notice', 'icon': 'assets/icons/notice.png', 'route': 'notice'},
    {'title': 'Developers', 'icon': 'assets/icons/about.png', 'route': 'about'}
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>> username() async* {
    yield* FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Color(0xFF2ECC71),
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
              SizedBox(
                height: 58,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: username(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final subjectName = document.get('f_name');
                        final subjectId = document.get('idnum');
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, $subjectName',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'ID : $subjectId ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onLongPress: () => Get.toNamed(test),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xFFEAECEE),
                                  child: Image.asset(
                                    'assets/icons/new.png',
                                    height: 40,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF2ECC71),
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: slidesCollection.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> slides = snapshot.data!.docs;
                  final double height = MediaQuery.of(context).size.height;

                  return InkWell(
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        //scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        height: 140,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        enlargeCenterPage: false,

                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: slides
                          .map(
                            (slide) => CachedNetworkImage(
                              imageUrl: slide['imageURL'],
                              key: UniqueKey(),
                              width: double.maxFinite,
                              height: height,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) => Container(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
              Divider(
                thickness: 1,
                height: 20,
                color: Color(0xFF2ECC71),
              ),
              SizedBox(
                height: 290,
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
                            top: 20,
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
                                style: TextStyle(
                                    color: Color(0xFF2ECC71),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(menu[index]['route']),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF2ECC71),
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
                                        color: Color(0xFF2ECC71)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
