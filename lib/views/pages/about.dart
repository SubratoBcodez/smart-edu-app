import 'package:flutter/material.dart';

class Developers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developers"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
          child: Column(
            children: [
              Text(
                "Schedule Notifier",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Divider(height: 10, thickness: 2, color: Colors.green),
              SizedBox(
                height: 10,
              ),
              Text(
                "The main theme of a schedule notifier application would be to provide timely reminders to users about their upcoming events, tasks, or appointments. The application should have a user-friendly interface that allows users to easily add and manage their schedules. Notifications should be customizable, allowing users to choose how and when they receive reminders.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Developers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.green,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Belal Hossain",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Text(
                "                   Dept of CSE \n Green University of Bangladesh",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 5,
                thickness: 1,
                color: Colors.green,
              ),
              Text(
                "Subrato Basak",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Text(
                "                   Dept of CSE \n Green University of Bangladesh",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 5,
                thickness: 1,
                color: Colors.green,
              ),
              Text(
                "Shah Jalal",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Text(
                "                   Dept of CSE \n Green University of Bangladesh",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Divider(
                height: 10,
                thickness: 2,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
