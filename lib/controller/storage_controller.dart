import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive/models/todo_model.dart';

class StorageController {
  List<Todo> todoList = [];
  final box = Hive.box('todo_box');

// add todo
  addTodo(String title) {
    todoList.add(Todo(title: title));
    debugPrint(title);
    box.put('todos', todoList);
  }

// get list of todos and update todoList
  getTodos() {
    final List tempList = box.get('todos');
    // debugPrint(tempList.toString());
    for (var todoTemp in tempList) {
      final todo = todoTemp as Todo;
      todoList.add(todo);
    }

    debugPrint(box.toMap().toString());
  }

// update the todo (mark complete)
  updateTodo(String id) {
    final index = todoList.indexWhere((element) => element.id == id);
    final todo = todoList.firstWhere((element) => element.id == id);

    if (index != -1) {
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      todoList.removeAt(index);
      todoList.insert(index, updatedTodo);
      box.put("todos", todoList);
    }
  }

// edit todo title
  updateTitle(String id, String title) {
    final index = todoList.indexWhere((element) => element.id == id);
    final todo = todoList.firstWhere((element) => element.id == id);

    if (index != -1) {
      final updatedTodo = todo.copyWith(title: title);
      todoList.removeAt(index);
      todoList.insert(index, updatedTodo);
      box.put("todos", todoList);
    }
  }

// remove todo from the list
  deleteTodo(Todo todo) {
    final index = todoList.indexWhere((element) => element == todo);
    todoList.removeAt(index);
    box.put('todos', todoList);
  }
}
