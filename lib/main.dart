import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:flutter_todo_bloc_app/cubits/filtered_todos/flitered_todo_cubit.dart';
import 'package:flutter_todo_bloc_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:flutter_todo_bloc_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:flutter_todo_bloc_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:flutter_todo_bloc_app/pages/todo_page/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(

          create: (context) => ActiveTodoCountCubit(
            initialActiveTodoCount: context.read<TodoListCubit>().state.todos.length,
              todoListCubit: BlocProvider.of<TodoListCubit>(context)),
        ),
        BlocProvider<FliteredTodoCubit>(
          create: (context) => FliteredTodoCubit(
            initialTodos: context.read<TodoListCubit>().state.todos,
              todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
              todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
              todoListCubit: BlocProvider.of<TodoListCubit>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoPage(),
      ),
    );
  }
}
