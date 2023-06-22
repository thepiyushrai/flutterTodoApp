import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/controller/TodoBloc.dart';
import 'package:flutter_to_do_app/ui/TodoListScreen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The root widget of the application.
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Wrap the TodoListScreen with a BlocProvider to provide the TodoBloc.
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc(),
        child: TodoListScreen(),
      ),
    );
  }
}
