import 'package:flutter/material.dart';
import 'package:to_do_list2/todo_model.dart';
import 'package:to_do_list2/todo_item.dart';

class ToDosList extends StatelessWidget {
  const ToDosList({Key? key, required this.todos, required this.editToDo}) : super(key: key);

  final List<ToDo> todos;
  final void Function(ToDo todo) editToDo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            editToDo(todos[index]);
          },
          child: ToDoItem(todos[index]),
        );
      },
    );
  }
}
