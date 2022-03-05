import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_app/cubits/cubits.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Todo_List',
          style: TextStyle(fontSize: 40.0),
        ),
        BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
          builder: (context, state) {
            return Text(
              '${state.activeTodoCount} tasks left',
              style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
            );
          },
        ),
      ],
    );
  }
}
