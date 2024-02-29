import 'package:flutter/material.dart';
import 'package:to_do_list2/todo_model.dart';

class NewToDo extends StatefulWidget {
  const NewToDo({
    Key? key,
    required this.onAddToDo,
    this.initialToDo,
    this.onDeleteToDo,
  }) : super(key: key);

  final void Function(ToDo toDo) onAddToDo;
  final void Function()? onDeleteToDo;
  final ToDo? initialToDo;

  @override
  State<NewToDo> createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  Priority _selectedPriority = Priority.mid;

  @override
  void initState() {
    super.initState();
    if (widget.initialToDo != null) {
      _titleController.text = widget.initialToDo!.title;
      _selectedDate = widget.initialToDo!.due;
      _selectedPriority = widget.initialToDo!.priority;
    }
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitToDoData() {
    widget.onAddToDo(
      ToDo(
        title: _titleController.text,
        due: _selectedDate!,
        priority: _selectedPriority,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 48, 25, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('todo')),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(_selectedDate == null
                  ? 'Pick the due'
                  : formatter.format(_selectedDate!)),
              IconButton(
                onPressed: presentDatePicker,
                icon: const Icon(Icons.calendar_month),
              ),
              const Spacer(),
              const Text('Priority'),
              const SizedBox(
                width: 15,
              ),
              DropdownButton(
                value: _selectedPriority,
                items: Priority.values
                    .map(
                      (priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedPriority = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.initialToDo != null)
                Expanded(
                  child: TextButton(
                    onPressed: widget.onDeleteToDo,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    backgroundColor: Color.fromARGB(255, 200, 217, 231).withOpacity(0.3)
                    ),
                    child: const Text(
                      'DELETE',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              if (widget.initialToDo != null)
                const SizedBox(
                  width: 20,
                ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 9, 77, 132),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submitToDoData,
                  child: Text(widget.initialToDo != null ? 'SAVE' : 'ADD', style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
