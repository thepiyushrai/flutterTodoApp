import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/db/DatabaseHelper.dart';
import 'package:flutter_to_do_app/oprn/AddTodo.dart';
import 'package:flutter_to_do_app/oprn/DeleteTodo.dart';
import 'package:flutter_to_do_app/oprn/LoadTodos.dart';
import 'package:flutter_to_do_app/oprn/TodoEvent.dart';
import 'package:flutter_to_do_app/oprn/UpdateTodo.dart';
import 'package:flutter_to_do_app/state/TodoLoaded.dart';
import 'package:flutter_to_do_app/state/TodoLoading.dart';
import 'package:flutter_to_do_app/state/TodoState.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  TodoBloc() : super(TodoLoading()) {
    add(LoadTodos());
  }

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield TodoLoading();
      final todos = await dbHelper.getTodos();
      yield TodoLoaded(todos: todos);
    } else if (event is AddTodo) {
      await dbHelper.insertTodo(event.todo);
      add(LoadTodos());
    } else if (event is UpdateTodo) {
      await dbHelper.updateTodo(event.todo);
      add(LoadTodos());
    } else if (event is DeleteTodo) {
      await dbHelper.deleteTodoById(event.id);
      add(LoadTodos());
    }
  }
}