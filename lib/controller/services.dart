import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/studentmodel.dart';

class StudentController extends GetxController {
  final Box<StudentModel> nameBox = Hive.box<StudentModel>('studentsBox');

  
  RxList<StudentModel> filteredStudents = <StudentModel>[].obs;
  RxString query = ''.obs; 
  RxString selectedImage = ''.obs; 

  @override
  void onInit() {
    super.onInit();

    filteredStudents.value = nameBox.values.toList();
  }

 
  List<StudentModel> get names => nameBox.values.toList();

  
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
    updateFilteredStudents(); 
  }

 
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
    updateFilteredStudents(); 
  }

 
  void deleteStudent(int index) {
    nameBox.deleteAt(index);
    updateFilteredStudents(); 
  }


  void filterStudents(String searchQuery) {
    query.value = searchQuery; 
    if (searchQuery.isEmpty) {
      updateFilteredStudents(); 
    } else {
      filteredStudents.value = names.where((student) {
        return student.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

 
  void updateFilteredStudents() {
    filteredStudents.value = names;
  }


  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      selectedImage.value = pickedImage.path; 
      return File(pickedImage.path);
    }
    return null;
  }

  
  void clearSelectedImage() {
    selectedImage.value = '';
  }
}