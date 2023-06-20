import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../custom/route.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF2ECC71),
      ),
      body: SingleChildScrollView(child: Body()),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFEAFAF1),
        ),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(width: 30),
            Expanded(
                child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF2ECC71)),
            )),
            Icon(Icons.edit),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final box = GetStorage();

  String? email;

  Stream<QuerySnapshot<Map<String, dynamic>>> username() async* {
    yield* FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  @override
  void initState() {
    email = box.read('email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
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
              final _img = document.get('picture');

              return SizedBox(
                height: 115,
                width: 115,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_img),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final box = GetStorage();

  String? email;

  Stream<QuerySnapshot<Map<String, dynamic>>> username() async* {
    yield* FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  @override
  void initState() {
    email = box.read('email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          SizedBox(
            height: 500,
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
                    final _fname = document.get('f_name');
                    final _idnum = document.get('idnum');
                    final _lname = document.get('l_name');
                    final _email = document.get('email');
                    return Column(
                      children: [
                        ProfilePic(),
                        SizedBox(height: 20),
                        ProfileMenu(
                          text: "$_fname",
                          icon: '',
                          press: () => {},
                        ),
                        ProfileMenu(
                          text: "$_lname",
                          icon: "",
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "$_idnum",
                          icon: "",
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "$_email",
                          icon: "",
                          press: () {},
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
