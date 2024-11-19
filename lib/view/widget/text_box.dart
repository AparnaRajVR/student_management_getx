import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({super.key, required this.icon, required this.name});
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(name,
                style: const TextStyle(
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }
}
