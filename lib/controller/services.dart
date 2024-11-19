import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/studentmodel.dart';

class StudentController extends GetxController {
  final Box<StudentModel> nameBox = Hive.box<StudentModel>('studentsBox');

  // Reactive variables
  RxList<StudentModel> filteredStudents = <StudentModel>[].obs;
  RxString query = ''.obs; // Search query for filtering students
  RxString selectedImage = ''.obs; // Reactive selected image path

  @override
  void onInit() {
    super.onInit();
    // Initially load all students into filteredStudents
    filteredStudents.value = nameBox.values.toList();
  }

  // Getter for all students
  List<StudentModel> get names => nameBox.values.toList();

  // Add a new student
  void addStudent({
    required String name,
    required String place,
    required String email,
    required int phone,
    required String imageUrl,
  }) {
    nameBox.add(StudentModel(
      name: name,
      place: place,
      email: email,
      phone: phone,
      imageUrl: imageUrl,
    ));
    updateFilteredStudents(); // Update filtered list
  }

  // Update an existing student
  void updateStudent(
    int index, {
    required String name,
    required String place,
    required String email,
    required int phone,
    required String imageUrl,
  }) {
    nameBox.putAt(
      index,
      StudentModel(
        name: name,
        place: place,
        email: email,
        phone: phone,
        imageUrl: imageUrl,
      ),
    );
    updateFilteredStudents(); // Update filtered list
  }

  // Delete a student
  void deleteStudent(int index) {
    nameBox.deleteAt(index);
    updateFilteredStudents(); // Update filtered list
  }

  // Search for students
  void filterStudents(String searchQuery) {
    query.value = searchQuery; // Update search query
    if (searchQuery.isEmpty) {
      updateFilteredStudents(); // If search is empty, show all students
    } else {
      filteredStudents.value = names.where((student) {
        return student.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

  // Update filteredStudents list with all students
  void updateFilteredStudents() {
    filteredStudents.value = names;
  }

  // Pick an image and update the selected image path
  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      selectedImage.value = pickedImage.path; // Update reactive variable
      return File(pickedImage.path);
    }
    return null;
  }

  // Clear the selected image path
  void clearSelectedImage() {
    selectedImage.value = '';
  }
}