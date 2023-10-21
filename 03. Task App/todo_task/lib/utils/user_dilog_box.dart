import 'package:flutter/material.dart';

class UserDialogBox extends StatefulWidget {
  const UserDialogBox({super.key});

  @override
  State<UserDialogBox> createState() => _UserDialogBoxState();
}

class _UserDialogBoxState extends State<UserDialogBox> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('UserName'),
      content: TextField(
        controller: nameController,
      ),
      actions: [
        TextButton(onPressed: () {}, child: const Text('Save')),
      ],
    );
  }
}
