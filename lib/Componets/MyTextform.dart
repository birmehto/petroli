import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onEditingComplete; // Updated this line

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.focusNode,
    this.nextFocusNode,
    this.onEditingComplete, // Updated this line
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      focusNode: focusNode,
      onEditingComplete: () {
        if (onEditingComplete != null) {
          onEditingComplete!(); // Call the callback with no arguments
        }
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
    );
  }
}
