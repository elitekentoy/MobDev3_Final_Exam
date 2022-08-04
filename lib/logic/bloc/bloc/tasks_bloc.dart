import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(onAddTask);
    on<UpdateTask>(onUpdateTask);
  }

  void onAddTask(AddTask event, Emitter<TasksState> emit){
    final state = this.state;
    emit(TasksState(
      taskList: List.from(state.taskList)..add(event.task),
    ));
  }

  void onUpdateTask(UpdateTask event, Emitter<TasksState> emit){
    final state = this.state;
    final task = event.task;

    List<Task> taskList = List.from(state.taskList)..remove(task);
    task.isDone == false
    ? taskList.add(task.copyWith(isDone: true))
    : taskList.add(task.copyWith(isDone: false));

    emit(TasksState(taskList: taskList));
  }
}
