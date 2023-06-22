import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/controller/TodoBloc.dart';
import 'package:flutter_to_do_app/model/Todo.dart';
import 'package:flutter_to_do_app/oprn/AddTodo.dart';
import 'package:flutter_to_do_app/oprn/DeleteTodo.dart';
import 'package:flutter_to_do_app/oprn/UpdateTodo.dart';
import 'package:flutter_to_do_app/state/TodoLoaded.dart';
import 'package:flutter_to_do_app/state/TodoLoading.dart';
import 'package:flutter_to_do_app/state/TodoState.dart';
// class TodoListScreen extends StatelessWidget {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: BlocBuilder<TodoBloc, TodoState>(
//         builder: (context, state) {
//           if (state is TodoLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is TodoLoaded) {
//             return ListView.separated(
//               itemCount: state.todos.length,
//               separatorBuilder: (context, index) => Divider(),
//               itemBuilder: (context, index) {
//                 final todo = state.todos[index];
//                 return buildTodoItem(context, todo);
//               },
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => buildAddTodoAlertDialog(context),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildTodoItem(BuildContext context, Todo todo) {
//     return ListTile(
//       key: ValueKey(todo.id),
//       title: Text(todo.title),
//       subtitle: Text(todo.description),
//       trailing: Checkbox(
//         value: todo.isCompleted,
//         onChanged: (value) {
//           final updatedTodo = Todo(
//             id: todo.id,
//             title: todo.title,
//             description: todo.description,
//             isCompleted: value ?? false,
//           );
//           context.read<TodoBloc>().add(UpdateTodo(
//             todo: updatedTodo,
//           ));
//         },
//       ),
//       onLongPress: () {
//         showDialog(
//           context: context,
//           builder: (context) => buildDeleteTodoAlertDialog(context, todo),
//         );
//       },
//     );
//   }
//
//   Widget buildAddTodoAlertDialog(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Todo'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _titleController,
//             decoration: InputDecoration(labelText: 'Title'),
//           ),
//           TextField(
//             controller: _descriptionController,
//             decoration: InputDecoration(labelText: 'Description'),
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Add'),
//           onPressed: () {
//             final newTodo = Todo(
//               id: 0,
//               title: _titleController.text,
//               description: _descriptionController.text,
//               isCompleted: false,
//             );
//             context.read<TodoBloc>().add(AddTodo(
//               todo: newTodo,
//             ));
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget buildDeleteTodoAlertDialog(BuildContext context, Todo todo) {
//     return AlertDialog(
//       title: Text('Delete Todo'),
//       content: Text('Are you sure you want to delete this todo?'),
//       actions: [
//         TextButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Delete'),
//           onPressed: () {
//             context.read<TodoBloc>().add(DeleteTodo(
//               id: todo.id,
//             ));
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }


class TodoListScreen extends StatelessWidget {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      final updatedTodo = Todo(
                        id: todo.id,
                        title: todo.title,
                        description: todo.description,
                        isCompleted: value ?? false,
                      );
                      context.read<TodoBloc>().add(UpdateTodo(
                        todo: updatedTodo,
                      ));
                    },
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Todo'),
                          content: Text('Are you sure you want to delete this todo?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                context.read<TodoBloc>().add(DeleteTodo(
                                  id: todo.id,
                                ));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Todo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      final newTodo = Todo(
                        id: 0,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                      );
                      context.read<TodoBloc>().add(AddTodo(
                        todo: newTodo,
                      ));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}


