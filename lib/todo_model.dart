import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final List<ToDo> _unorganizedToDo = [];
final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Priority { high, mid, low }

const priorityIcons = {
  Priority.high: Icon(
    Icons.arrow_drop_up_rounded,
    color: Colors.red,
    size: 50,
  ),
  Priority.mid: SizedBox(
    width: 50,
  ),
  Priority.low: Icon(
    Icons.arrow_drop_down_rounded,
    color: Colors.green,
    size: 50,
  ),
};

class ToDo {
  ToDo({
    required this.title,
    required this.due,
    required this.priority,
    this.isChecked = false, // Added property to track checked state
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime due;
  final Priority priority;
  bool isChecked; // Added property to track checked state

  String get formattedDue {
    return formatter.format(due);
  }

  List<ToDo> get organizedToDo {
    return _unorganizedToDo
        // ignore: unnecessary_null_comparison
        .where((todo) => todo.priority != null)
        .toList()
        ..sort((a, b) => a.priority.index.compareTo(b.priority.index));
  }
}
