// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AddHabit extends StatelessWidget {
  final void Function() addTodo;
  final TextEditingController textController;
  const AddHabit({
    Key? key,
    required this.addTodo,
    required this.textController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add todo"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Habit Title',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton.tonal(
              onPressed: () {
                addTodo();

                Navigator.pop(context);

                textController.clear();
              },
              child: const Text("Add"),
            ),
          )
        ],
      ),
    );
  }
}
