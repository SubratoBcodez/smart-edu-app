import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/custom/style.dart';
import 'package:untitled5/views/pages/final_exam.dart';
import 'package:untitled5/views/pages/makeup_exam.dart';
import 'package:untitled5/views/pages/mid_exam.dart';

class ExamNav extends StatelessWidget {
  final _pages = [
    MidExam(),
    FinalExam(),
    MakeupExam(),
  ];

  var _currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex.value,
              onTap: (value) {
                _currentIndex.value = value;
              },
              items: [
                AppStyle().navBar(Icons.edit_note_outlined, 'Mid'),
                AppStyle().navBar(Icons.edit_note_outlined, 'Final'),
                AppStyle().navBar(Icons.edit_note_outlined, 'Makeup')
              ]),
          body: _pages[_currentIndex.value],
        ));
  }
}
