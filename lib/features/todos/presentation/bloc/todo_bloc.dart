import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hastools/features/todos/data/models/todo_model/index.dart';
import 'package:hastools/features/todos/data/repositories/todo_repository_impl.dart';

part 'todo_bloc.freezed.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.fetchTodos() = FetchTodos;
  const factory TodoEvent.addTodo({
    required String title,
  }) = AddTodo;
}

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = TodoInitial;
  const factory TodoState.loading() = TodoLoading;
  const factory TodoState.loaded({
    required List<TodoModel> todos,
  }) = TodosLoaded;
  const factory TodoState.error({
    required String message,
  }) = TodoError;
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({required this.repository}) : super(const TodoState.initial()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(const TodoState.loading());
    try {
      final todos = await repository.getTodos();
      emit(TodoState.loaded(todos: todos));
    } catch (e) {
      emit(TodoState.error(message: e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      await repository.createTodo(event.title);
      final todos = await repository.getTodos();
      emit(TodoState.loaded(todos: todos));
    } catch (e) {
      emit(TodoState.error(message: e.toString()));
    }
  }
}
