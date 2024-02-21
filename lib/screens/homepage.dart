import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/controller/storage_controller.dart';
import 'package:todo_hive/models/todo_model.dart';
import 'package:todo_hive/screens/add_habit.page.dart';
import 'package:todo_hive/screens/update_todo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final box = Hive.box('todo_box');

  final StorageController db = StorageController();

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if (box.get('todos') == null) {
      db.todoList = [];
    } else {
      db.getTodos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // add todo
    void addTodo() {
      db.addTodo(textEditingController.text.trim());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Hive"),
        centerTitle: true,
      ),
      body: Center(
          child: StreamBuilder(
              stream: box.watch(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: db.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = db.todoList[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: ListTile(
                        onTap: () {
                          final TextEditingController titleController =
                              TextEditingController(text: todo.title);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTodo(
                                  deleteTodo: () {
                                    db.deleteTodo(todo);
                                  },
                                  titleController: titleController,
                                  updateTodo: () {
                                    db.updateTitle(
                                        todo.id, titleController.text.trim());
                                  },
                                  todo: todo),
                            ),
                          );
                        },
                        title: Text(todo.title),
                        trailing: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            db.updateTodo(todo.id);
                          },
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                    );
                  },
                );
              })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHabit(
                  textController: textEditingController,
                  addTodo: addTodo,
                ),
              ));
        },
        label: const Text("Add Todo"),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}


// value listen

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Todo Hive"),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //       child: ValueListenableBuilder(
    //           valueListenable: box.listenable(),
    //           builder: (BuildContext context, Box box, Widget? widget) {
    //             return ListView.builder(
    //               itemCount: db.todoList.length,
    //               itemBuilder: (context, index) {
    //                 final todo = db.todoList[index];
    //                 return Padding(
    //                   padding:
    //                       const EdgeInsets.only(left: 8, right: 8, bottom: 8),
    //                   child: ListTile(
    //                     onTap: () {
    //                       final TextEditingController titleController =
    //                           TextEditingController(text: todo.title);
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => UpdateTodo(
    //                               deleteTodo: () {
    //                                 db.deleteTodo(todo);
    //                               },
    //                               titleController: titleController,
    //                               updateTodo: () {
    //                                 db.updateTitle(
    //                                     todo.id, titleController.text.trim());
    //                               },
    //                               todo: todo),
    //                         ),
    //                       );
    //                     },
    //                     title: Text(todo.title),
    //                     trailing: Checkbox(
    //                       value: todo.isCompleted,
    //                       onChanged: (value) {
    //                         db.updateTodo(todo.id);
    //                       },
    //                     ),
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(20)),
    //                     tileColor:
    //                         Theme.of(context).colorScheme.primaryContainer,
    //                   ),
    //                 );
    //               },
    //             );
    //           })),
    //   floatingActionButton: FloatingActionButton.extended(
    //     onPressed: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => AddHabit(
    //               textController: textEditingController,
    //               addTodo: addTodo,
    //             ),
    //           ));
    //     },
    //     label: const Text("Add Todo"),
    //     icon: const Icon(Icons.add_rounded),
    //   ),
    // );


// stream

// return Scaffold(
//       appBar: AppBar(
//         title: const Text("Todo Hive"),
//         centerTitle: true,
//       ),
//       body: Center(
//           child: StreamBuilder(
//               stream: box.watch(),
//               builder: (context, snapshot) {
//                 return ListView.builder(
//                   itemCount: db.todoList.length,
//                   itemBuilder: (context, index) {
//                     final todo = db.todoList[index];
//                     return Padding(
//                       padding:
//                           const EdgeInsets.only(left: 8, right: 8, bottom: 8),
//                       child: ListTile(
//                         onTap: () {
//                           final TextEditingController titleController =
//                               TextEditingController(text: todo.title);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateTodo(
//                                   deleteTodo: () {
//                                     db.deleteTodo(todo);
//                                   },
//                                   titleController: titleController,
//                                   updateTodo: () {
//                                     db.updateTitle(
//                                         todo.id, titleController.text.trim());
//                                   },
//                                   todo: todo),
//                             ),
//                           );
//                         },
//                         title: Text(todo.title),
//                         trailing: Checkbox(
//                           value: todo.isCompleted,
//                           onChanged: (value) {
//                             db.updateTodo(todo.id);
//                           },
//                         ),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         tileColor:
//                             Theme.of(context).colorScheme.primaryContainer,
//                       ),
//                     );
//                   },
//                 );
//               })),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AddHabit(
//                   textController: textEditingController,
//                   addTodo: addTodo,
//                 ),
//               ));
//         },
//         label: const Text("Add Todo"),
//         icon: const Icon(Icons.add_rounded),
//       ),
//     );