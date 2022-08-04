import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(onAddTask);
  }

  void onAddTask(AddTask event, Emitter<TasksState> emit){
    final state = this.state;
    emit(TasksState(
      taskList: List.from(state.taskList)..add(event.task),
    ));
  }
}
