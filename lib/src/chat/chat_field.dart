import 'package:flutter/material.dart';

class ChatField extends StatelessWidget {
  const ChatField({super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: const InputDecoration(),
    );
  }
}
