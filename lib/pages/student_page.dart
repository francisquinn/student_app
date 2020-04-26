import 'package:flutter/material.dart';
import 'package:student_app/model/Student.dart';

class StudentPage extends StatelessWidget {
  final Student student;

  StudentPage(this.student);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Text(
            student.name,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}