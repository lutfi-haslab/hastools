import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/features/todos/presentation/bloc/todo_bloc.dart';

class TodoScreen extends StatelessWidget {
  final _textController = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Todo",
      enablePullRefresh: true,
      showBackButton: false,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodosLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        leading: Checkbox(
                          value: todo.completed,
                          onChanged: (bool? value) {
                            // Implement toggle functionality
                          },
                        ),
                        onTap: () {
                          context.push('/todo/details');
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Add a new todo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            context.read<TodoBloc>().add(
                                  AddTodo(title: _textController.text),
                                );
                            _textController.clear();
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No todos yet'));
        },
      ),
    );
  }
}
