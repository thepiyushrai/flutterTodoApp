import 'package:flutter_to_do_app/model/Todo.dart';

import 'TodoEvent.dart';

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo({
    required this.todo,
  });
}