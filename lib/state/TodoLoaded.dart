import 'package:flutter_to_do_app/model/Todo.dart';
import 'package:flutter_to_do_app/state/TodoState.dart';

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded({
    required this.todos,
  });
}