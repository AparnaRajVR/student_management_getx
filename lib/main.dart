

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:hive_flutter/hive_flutter.dart';
import 'controller/services.dart';
import 'model/studentmodel.dart';
import 'view/screen/add_student.dart';
import 'view/screen/edit_student.dart';
import 'view/screen/home_screen.dart';
import 'view/screen/student_profile.dart'; // Assuming HomeScreen is here

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('studentsBox');

  // Initialize dependencies for GetX
  Get.put(StudentController()); // Replace ChangeNotifierProvider with Get.put for GetX

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      // Setup your routes
      initialRoute: '/home',  // Starting route
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/add-student', page: () => AddStudentPage()), 
        GetPage(name: '/edit-student', page: () => EditStudentScreen()), 
        GetPage( name: '/student-details',page: () => StudentDetailPage(student: Get.arguments as StudentModel,
  ),
),

      ],
    );
  }
}
