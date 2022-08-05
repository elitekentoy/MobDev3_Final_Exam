import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../logic/bloc/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return Chip(
                  label: Text(
                    '${state.pendingTaskList.length} Pending | ${state.completedTaskList.length} Completed',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return TasksList(tasksList: state.pendingTaskList);
            },
          ),
        ],
      ),
    );
  }
}
