import 'package:flutter/material.dart';
import 'package:to_do_app/controllers/todocontroller.dart';
import 'package:to_do_app/models/todo_model.dart';

class ToDoProvider extends ChangeNotifier {
  final TodoController _todoController = TodoController();
  final ScrollController scrollController = ScrollController();
  List<TodoModel> _todos = [];
  List<TodoModel> _searchlist = [];

  List<TodoModel> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _todoController.fetchTodos();
    notifyListeners();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final updatedTodo = await _todoController.updateTodo(todo);
    final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
    _todos[index] = updatedTodo;
    notifyListeners();
  }

  void toggle(int index) {
    _todos[index].completed = !_todos[index].completed!;
    updateTodo(
      _todos[index],
    );
  }

  void delete(int index) {
    _todoController.deleteTodo(
      _todos[index].id!,
    );
    _todos.removeAt(index);
    notifyListeners();
  }

  void addToDo(
      {required String title,
      required String description,
      required DateTime dueDate}) {
    _todoController.addTodo(
        title: title, description: description, dueDate: dueDate);

    notifyListeners();
  }

  void search(int index) {
    _searchlist.add(_todos[index]);

    notifyListeners();
  }

  get searchlist => _searchlist;

  Widget searchedItem() {
    return ListView.builder(
      itemCount: _searchlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey[300],
          child: GestureDetector(
            onTap: () {
              scrollToIndex(_searchlist[index].id!);
            },
            child: ListTile(
              title: Text(_searchlist[index].title!),
            ),
          ),
        );
      },
    );
  }

  void scrollToIndex(int id) {
    int index = _todos.indexWhere((element) => element.id == id);
    scrollController.animateTo(
      index * 100.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
