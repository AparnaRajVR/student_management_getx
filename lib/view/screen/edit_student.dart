import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/studentmodel.dart';
import '../../controller/services.dart';
import '../widget/custom_textform.dart';

class EditStudentScreen extends StatelessWidget {
  final StudentController controller = Get.find<StudentController>();

  EditStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final StudentModel student = arguments['student'];
    final int index = arguments['index'];

    final nameController = TextEditingController(text: student.name);
    final placeController = TextEditingController(text: student.place);
    final emailController = TextEditingController(text: student.email);
    final phoneController =
        TextEditingController(text: student.phone.toString());
    final RxString imageUrl = RxString(student.imageUrl);

    Future<void> pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageUrl.value = pickedFile.path;
      } else {
        Get.snackbar(
          'Image Selection',
          'No image selected!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: imageUrl.value.isNotEmpty
                          ? FileImage(File(imageUrl.value))
                          : const AssetImage('assets/profile.png')
                              as ImageProvider,
                      child: imageUrl.value.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  )),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: nameController,
                prefixIcon: const Icon(Icons.person),
                labelText: 'Name',
                keyboardtype: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: placeController,
                prefixIcon: const Icon(Icons.location_on),
                labelText: 'Place',
                keyboardtype: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email',
                keyboardtype: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: phoneController,
                prefixIcon: const Icon(Icons.phone),
                labelText: 'Phone',
                keyboardtype: TextInputType.number,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  controller.updateStudent(
                    index,
                    name: nameController.text,
                    place: placeController.text,
                    email: emailController.text,
                    phone: int.tryParse(phoneController.text) ?? student.phone,
                    imageUrl: imageUrl.value,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 85, 187, 177),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
