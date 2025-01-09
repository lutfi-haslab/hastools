import 'package:hastools/core/network/dio_client.dart';
import 'package:hastools/features/todos/data/models/todo_model/index.dart';

class TodoRepository {
  final DioClient _dioClient;

  TodoRepository({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await _dioClient.get('/todos');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => TodoModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<TodoModel> createTodo(String title) async {
    try {
      final data = {
        'title': title,
        'completed': false,
      };

      final response = await _dioClient.post('/todos', data);

      if (response.data is List && (response.data as List).isNotEmpty) {
        // Some APIs return array with single item
        return TodoModel.fromJson(response.data[0]);
      } else if (response.data is Map) {
        // Direct object response
        return TodoModel.fromJson(response.data);
      } 
      else {
        // If no immediate response, fetch the latest todos
        final todos = await getTodos();
        return todos.firstWhere((todo) => todo.title == title);
      }
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }
}
