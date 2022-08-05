import 'package:bloc_finals_exam/logic/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task.dart';
import '../test_data.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasksList = TestData.completedTasks;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('${tasksList.length} Tasks'),
                ),
              ),
              const SizedBox(height: 10),
              TasksList(tasksList: tasksList),
            ],
          ),
        );
      },
    );
  }
}
