// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_hive/models/todo_model.dart';

class UpdateTodo extends StatelessWidget {
  final void Function() updateTodo;
  final void Function() deleteTodo;
  final TextEditingController titleController;
  final Todo todo;
  const UpdateTodo({
    Key? key,
    required this.titleController,
    required this.updateTodo,
    required this.todo,
    required this.deleteTodo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update todo"),
        actions: [
          IconButton.filledTonal(
              onPressed: () {
                deleteTodo();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_rounded))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
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
                updateTodo();

                Navigator.pop(context);

                titleController.clear();
              },
              child: const Text("Add"),
            ),
          )
        ],
      ),
    );
  }
}
