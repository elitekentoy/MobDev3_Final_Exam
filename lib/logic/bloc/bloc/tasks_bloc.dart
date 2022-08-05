import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(onAddTask);
    on<UpdateTask>(onUpdateTask);
    on<RemoveTask>(onRemoveTask);
    on<DeleteTask>(onDeleteTask);
  }

  void onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      taskList: List.from(state.taskList)..add(event.task),
      removedTaskList: state.removedTaskList
    ));
  }

  void onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.taskList.indexOf(task);

    List<Task> taskList = List.from(state.taskList)..remove(task);
    task.isDone == false
        ? taskList.insert(index, task.copyWith(isDone: true))
        : taskList.insert(index, task.copyWith(isDone: false));

    emit(TasksState(taskList: taskList, removedTaskList: state.removedTaskList));
  }

  void onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        taskList: List.from(state.taskList)..remove(event.task),
        removedTaskList: List.from(state.removedTaskList)
          ..add(event.task.copyWith(isDeleted: true))));
  }

  void onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(taskList: List.from(state.taskList)..remove(event.task)));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
