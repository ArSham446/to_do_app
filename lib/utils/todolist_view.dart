import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../Provider/todomange.dart';

class ToDoList extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;
  final int index;
  final String? date;
  const ToDoList(
      {super.key,
      required this.title,
      required this.isDone,
      required this.onToggle,
      required this.index,
      this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(
                  onPressed: (context) {
                    Provider.of<ToDoProvider>(context, listen: false)
                        .delete(index);
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.redAccent),
            ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              top: 10.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: isDone,
                        onChanged: (value) {
                          onToggle();
                        }),
                    Text(
                      title,
                      style: TextStyle(
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 32,
                    ),
                    Text(
                      Provider.of<ToDoProvider>(context)
                          .todos[index]
                          .description!,
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      Provider.of<ToDoProvider>(context).todos[index].date!,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
