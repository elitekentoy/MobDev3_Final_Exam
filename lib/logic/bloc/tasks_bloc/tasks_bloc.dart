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
    on<MarkFavoriteOrUnfavoriteTask>(onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(onEditTask);
  }

  void onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTaskList: List.from(state.pendingTaskList)..add(event.task),
        removedTaskList: state.removedTaskList,
        favoriteTaskList: state.favoriteTaskList,
        completedTaskList: state.completedTaskList,
      ),
    );
  }

  void onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTaskList = state.pendingTaskList;
    List<Task> completedTaskList = state.completedTaskList;
    task.isDone == false
        ? {
            pendingTaskList = List.from(pendingTaskList)..remove(task),
            completedTaskList = List.from(completedTaskList)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            completedTaskList = List.from(completedTaskList)..remove(task),
            pendingTaskList = List.from(pendingTaskList)
              ..insert(0, task.copyWith(isDone: false)),
          };

    emit(TasksState(
      pendingTaskList: pendingTaskList,
      removedTaskList: state.removedTaskList,
      completedTaskList: completedTaskList,
      favoriteTaskList: state.favoriteTaskList,
    ));
  }

  void onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTaskList: List.from(state.pendingTaskList)..remove(event.task),
        removedTaskList: List.from(state.removedTaskList)
          ..add(event.task.copyWith(isDeleted: true)),
        favoriteTaskList: List.from(state.favoriteTaskList)..remove(event.task),
        completedTaskList: List.from(state.completedTaskList)
          ..remove(event.task),
      ),
    );
  }

  void onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTaskList: state.pendingTaskList,
          removedTaskList: List.from(state.removedTaskList)..remove(event.task),
          completedTaskList: state.completedTaskList,
          favoriteTaskList: state.favoriteTaskList),
    );
  }

  void onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit){
    final state = this.state;
    List<Task> pendingTasksList = state.pendingTaskList;
    List<Task> completedTaskList = state.completedTaskList;
    List<Task> favoriteTaskList = state.favoriteTaskList;

    if(event.task.isDone == false){
      if(event.task.isFavorite == false){
        var taskIndex = pendingTasksList.indexOf(event.task);
        pendingTasksList = List.from(pendingTasksList)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTaskList.insert(favoriteTaskList.length, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasksList.indexOf(event.task);
        pendingTasksList = List.from(pendingTasksList)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTaskList.remove(event.task);
      }
    } else {
      if(event.task.isFavorite == false ){
        var taskIndex = completedTaskList.indexOf(event.task);
        completedTaskList = List.from(completedTaskList)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTaskList.insert(favoriteTaskList.length, event.task.copyWith(isFavorite: true));
      }
      else{
        var taskIndex = completedTaskList.indexOf(event.task);
        completedTaskList = List.from(completedTaskList)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTaskList.remove(event.task);
      }
    }

    emit(TasksState(
      pendingTaskList: pendingTasksList,
      completedTaskList: completedTaskList,
      favoriteTaskList: favoriteTaskList,
      removedTaskList: state.removedTaskList
    ));
  }


  void onEditTask(EditTask event, Emitter<TasksState> emit){
    final state = this.state;
    List<Task> favoriteTaskList = state.favoriteTaskList;
    if(event.oldTask.isFavorite == true){
      favoriteTaskList
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    } 

    emit (
      TasksState(
        pendingTaskList: List.from(state.pendingTaskList)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTaskList: state.completedTaskList..remove(event.oldTask),
        favoriteTaskList: favoriteTaskList,
        removedTaskList: state.removedTaskList,
      ),
    );
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
