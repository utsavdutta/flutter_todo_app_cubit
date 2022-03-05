import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_app/cubits/cubits.dart';
import 'package:flutter_todo_bloc_app/models/todo_model.dart';

import '../../cubits/filtered_todos/flitered_todo_cubit.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({Key? key}) : super(key: key);

  Widget showBackgroundColor(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FliteredTodoCubit>().state.filteredTodos;
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackgroundColor(0),
            secondaryBackground: showBackgroundColor(1),
            confirmDismiss: (_) {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you really want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('No')),
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Yes'))
                      ],
                    );
                  });
            },
            onDismissed: (_) {
              context.read<TodoListCubit>().removeTodo(todos[index]);
            },
            child: TodoItem(todo: todos[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemCount: todos.length);
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textEditingController.text = widget.todo.desc;

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Task'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: _error ? 'value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => {
                              setState(() {
                                _error = textEditingController.text.isEmpty
                                    ? true
                                    : false;

                                if (!_error) {
                                  context.read<TodoListCubit>().editTodo(
                                      widget.todo.id,
                                      textEditingController.text);
                                  Navigator.pop(context);
                                }
                              })
                            },
                        child: const Text('Edit')),
                  ],
                );
              });
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
