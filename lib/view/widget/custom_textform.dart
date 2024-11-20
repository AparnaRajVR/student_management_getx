import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final String labelText;
  final TextInputType keyboardtype;
  final ValueChanged<String>? onChanged; 

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.labelText,
    required this.keyboardtype,
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardtype,
        cursorColor: Colors.blue[800],
        onChanged: onChanged, // Use onChanged if provided
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '* Field is Empty';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
