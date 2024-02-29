import 'package:flutter/material.dart';
import 'package:to_do_list2/todo_model.dart';

class ToDoItem extends StatefulWidget {
  const ToDoItem(this.todo, {Key? key}) : super(key: key);

  final ToDo todo;

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: Row(
        children: [
          Checkbox(
            shape: const CircleBorder(),
            value: widget.todo.isChecked,
            onChanged: (bool? value) {
              setState(() {
                widget.todo.isChecked = value ?? false;
              });
            },
          ),
          Text(
            widget.todo.title,
            style: TextStyle(
              decoration:
                  widget.todo.isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
          Spacer(),
          Text(widget.todo.formattedDue),
          SizedBox(width: 10,),
          Container(child: priorityIcons[widget.todo.priority]),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}