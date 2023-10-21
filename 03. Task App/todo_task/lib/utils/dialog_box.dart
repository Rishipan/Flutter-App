import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController dateController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.titleController,
    required this.contentController,
    required this.onCancel,
    required this.onSave,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange.shade200,
      title: const Text('Add New Task'),
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task Title',
              ),
            ),
            TextField(
              controller: contentController,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task Content(optional)',
              ),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Time(optional)',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        MaterialButton(
          onPressed: onSave,
          color: Colors.amber,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
