import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../controller/services.dart';
import '../../model/studentmodel.dart';

import '../widget/dialog_box.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final StudentController controller = Get.find<StudentController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student\'s Portal'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search students...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
              ),
              onChanged: (value) => controller.filterStudents(value),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.filteredStudents.isEmpty) {
                return const Center(child: Text('No students found'));
              }
              return ListView.builder(
                itemCount: controller.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = controller.filteredStudents[index];
                  return _buildStudentCard(student, index);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-student'),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStudentCard(StudentModel student, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        onTap: () => Get.toNamed('/student-details', arguments: student),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: student.imageUrl.isNotEmpty
              ? FileImage(File(student.imageUrl))
              : null,
          child: student.imageUrl.isEmpty
              ? const Icon(Icons.person, color: Colors.grey)
              : null,
        ),
        title: Text(student.name),
        subtitle: Text(student.place),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.teal),
              onPressed: () => _editStudent(student, index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteDialog(index),
            ),
          ],
        ),
      ),
    );
  }

  void _editStudent(StudentModel student, int index) {
    Get.toNamed('/edit-student',
        arguments: {'student': student, 'index': index});
  }

  void _showDeleteDialog(int index) {
    Get.dialog(
      DeleteDialog(
        onDelete: () {
          Get.back();
          controller.deleteStudent(index);
        },
      ),
    );
  }
}
