import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Provider/todomange.dart';

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final description = TextEditingController();
    late DateTime dueDate = DateFormat.MMMEd() as DateTime;
    return AlertDialog(
      title: const Text('Add a new task'),
      content: Column(
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(hintText: 'Enter Task Name'),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(hintText: 'Enter Description'),
          ),
          IconButton(
              onPressed: () async {
                dueDate = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2030)))!;
              },
              icon: const Icon(Icons.calendar_today))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Provider.of<ToDoProvider>(context, listen: false).addToDo(
                  title: title.text,
                  description: description.text,
                  dueDate: dueDate);
              Navigator.of(context).pop();
            },
            child: const Text('Add')),
      ],
    );
  }
}
