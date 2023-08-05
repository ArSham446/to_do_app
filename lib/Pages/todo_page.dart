import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/utils/dialoguebox.dart';
import 'package:to_do_app/utils/todolist_view.dart';

import '../Provider/todomange.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<ToDoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                SearchBar(
                  hintText: 'Search Todo',
                  onChanged: (value) {
                    todoprovider.searchlist.clear();
                    for (int i = 0; i < todoprovider.todos.length; i++) {
                      if (todoprovider.todos[i].title!.contains(value)) {
                        if (value.isEmpty) {
                          todoprovider.searchlist.clear();
                        } else {
                          todoprovider.search(i);
                        }

                        setState(() {});
                      }
                    }
                  },
                ),
                Expanded(
                  child: FutureBuilder(
                    future: Provider.of<ToDoProvider>(context, listen: false)
                        .fetchTodos(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                        controller: todoprovider.scrollController,
                        itemCount:
                            Provider.of<ToDoProvider>(context).todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (Provider.of<ToDoProvider>(context)
                              .todos
                              .isEmpty) {
                            return const Center(
                                child: Text("Lets Add some tasks"));
                          } else {
                            return ToDoList(
                              title: todoprovider.todos[index].title!,
                              isDone: todoprovider.todos[index].completed!,
                              onToggle: () {
                                todoprovider.toggle(index);
                              },
                              index: index,
                              date: todoprovider.todos[index].date!,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Visibility(
          //   visible: todoprovider.searchlist.isNotEmpty,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Positioned(
          //         top: 50, child: Expanded(child: todoprovider.searchedItem())),
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DialogueBox();
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
