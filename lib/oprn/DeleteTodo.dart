import 'package:flutter_to_do_app/oprn/TodoEvent.dart';

class DeleteTodo extends TodoEvent {
  final int id;

  DeleteTodo({
    required this.id,
  });
}