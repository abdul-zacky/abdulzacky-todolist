import 'package:flutter/material.dart';
import 'package:to_do_list2/new_todo.dart';
import 'package:to_do_list2/profile.dart';
import 'package:to_do_list2/todo_model.dart';
import 'package:to_do_list2/todos_list.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedPageIndex = 0;
  bool isChecked = false;
  final List<ToDo> _initializedTodo = [
    ToDo(
      title: 'Do the dishes',
      due: DateTime.now(),
      priority: Priority.low,
    ),
    ToDo(
      title: 'Do my homework',
      due: DateTime.now(),
      priority: Priority.high,
    ),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void openAddToDoOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: 3 / 4,
          child: NewToDo(onAddToDo: _addToDo),
        );
      });
  }

  void _addToDo(ToDo toDo) {
    _initializedTodo
        .where((todo) => todo.priority != null)
        .toList()
        .sort((a, b) => a.priority.index.compareTo(b.priority.index));
    setState(() {
      _initializedTodo.add(toDo);
    });
  }

  void _removeToDo(ToDo todo) {
    setState(() {
      _initializedTodo.remove(todo);
    });
  }

  void _editToDo(ToDo todo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return FractionallySizedBox(
          heightFactor: 3 / 4,
          child: NewToDo(
            onAddToDo: (editedToDo) {
              _updateToDo(todo, editedToDo);
            },
            onDeleteToDo: () {
              _removeToDo(todo);
              Navigator.pop(context);
            },
            initialToDo: todo,
          ),
        );
      },
    );
  }

  void _updateToDo(ToDo oldToDo, ToDo newToDo) {
    setState(() {
      final index = _initializedTodo.indexOf(oldToDo);
      _initializedTodo[index] = newToDo;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget homeContent = const Center(
      child: Text('You have nothing to do!'),
    );
    if (_initializedTodo.isNotEmpty) {
      homeContent = ToDosList(todos: _initializedTodo, editToDo: _editToDo);
    }
    if (_selectedPageIndex == 1) {
      homeContent = const ProfileScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              'todo',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: openAddToDoOverlay,
            icon: const Icon(Icons.add_circle_rounded),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: homeContent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 30,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
