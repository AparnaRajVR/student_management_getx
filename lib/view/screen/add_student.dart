import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/services.dart';
import '../widget/custom_textform.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({Key? key}) : super(key: key);

  final StudentController controller = Get.find<StudentController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Image Section
              Center(
                child: Stack(
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: controller.selectedImage.value.isNotEmpty
                          ? FileImage(File(controller.selectedImage.value))
                          : null,
                      child: controller.selectedImage.value.isEmpty
                          ? const Icon(Icons.person, size: 40, color: Colors.grey)
                          : null,
                    )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () => _showImageSourceDialog(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Custom Form Fields
              CustomTextfield(
                controller: nameController,
                prefixIcon: const Icon(Icons.person),
                labelText: 'Name',
                keyboardtype: TextInputType.text,
              ),
              const SizedBox(height: 16),
              
              CustomTextfield(
                controller: placeController,
                prefixIcon: const Icon(Icons.place),
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
                keyboardtype: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _saveStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      controller.addStudent(
        name: nameController.text,
        place: placeController.text,
        email: emailController.text,
        phone: int.parse(phoneController.text),
        imageUrl: controller.selectedImage.value,
      );
      Get.back();
      Get.snackbar(
        'Success',
        'Student added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}