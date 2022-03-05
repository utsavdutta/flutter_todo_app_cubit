import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc_app/pages/todo_page/create_todo.dart';
import 'package:flutter_todo_bloc_app/pages/todo_page/search_and_filter_todo.dart';
import 'package:flutter_todo_bloc_app/pages/todo_page/show_todos.dart';
import 'package:flutter_todo_bloc_app/pages/todo_page/todo_header.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: const [
            TodoHeader(),
            CreateTodo(),
            SizedBox(
              height: 20.0,
            ),
            SearchAndFilterTodo(),
            SizedBox(
              height: 5.0,
            ),
            ShowTodo()
          ],
        ),
      )),
    );
  }
}
