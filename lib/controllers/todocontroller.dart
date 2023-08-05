import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_model.dart';

const String urL = 'http://localhost:8000/api/todo/';

class TodoController {
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final url = Uri.parse(urL);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final url = Uri.parse('$urL${todo.id}/');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(todo.toJson());
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TodoModel.fromJson(data);
      } else {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      print(e);
      return todo;
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final url = Uri.parse('$urL$id/');
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        // Todo deleted successfully
      } else {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<TodoModel> addTodo({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    try {
      final url = Uri.parse(urL);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'title': title,
        'description': description,
        'completed':false,
        'due_date': dueDate.toIso8601String(),
        
      });
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return TodoModel.fromJson(data);
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
