// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

Uuid uuid = const Uuid();

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isCompleted;
  @HiveField(2)
  final String id;
  Todo({
    required this.title,
    this.isCompleted = false,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isCompleted': isCompleted,
      'id': id,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  Todo copyWith({
    String? title,
    bool? isCompleted,
    String? id,
  }) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }
}


// class Todo {
//   final String title;
//   final bool isCompleted;
//   final String id;
//   Todo({
//     required this.title,
//     required this.isCompleted,
//     required this.id,
//   });
// }
