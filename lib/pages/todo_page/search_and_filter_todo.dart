import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:flutter_todo_bloc_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:flutter_todo_bloc_app/models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
              labelText: 'Search task',
              border: InputBorder.none,
              filled: true,
              prefixIcon: Icon(Icons.search)),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterbutton(context, Filter.all),
            filterbutton(context, Filter.active),
            filterbutton(context, Filter.completed)
          ],
        )
      ],
    );
  }

  filterbutton(BuildContext context, Filter filter) {
    return TextButton(
        onPressed: () {
          context.read<TodoFilterCubit>().changeFilter(filter);
        },
        child: Text(
          filter == Filter.all
              ? 'All'
              : filter == Filter.active
                  ? 'Active'
                  : 'Completed',
          style: TextStyle(fontSize: 18.0, color: textColor(context, filter)),
        ));
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterCubit>().state.filter;

    return currentFilter == filter ? Colors.blueAccent : Colors.grey;
  }
}
