import 'dart:io';

import 'package:flutter/material.dart';
import '../../model/studentmodel.dart';
import '../widget/text_box.dart';

class StudentDetailPage extends StatelessWidget {
  final StudentModel student;

  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student.name} Details'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: student.imageUrl.isNotEmpty
                    ? FileImage(File(student.imageUrl))
                    : const AssetImage('assets/profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            // Custom TextBox for displaying details
            CustomTextBox(
              icon: Icons.person,
              name: student.name,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              icon: Icons.location_on,
              name: student.place,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              icon: Icons.email,
              name: student.email,
            ),
            const SizedBox(height: 10),
            CustomTextBox(
              icon: Icons.phone,
              name: student.phone.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
