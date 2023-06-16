import '../model/Todo.dart';
import 'TodoEvent.dart';

class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo({
    required this.todo,
  });
}