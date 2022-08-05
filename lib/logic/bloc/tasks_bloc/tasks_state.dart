// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTaskList;
  final List<Task> removedTaskList;
  final List<Task> favoriteTaskList;
  final List<Task> completedTaskList;

  const TasksState({
    this.pendingTaskList = const <Task>[],
    this.removedTaskList = const <Task>[],
    this.favoriteTaskList = const <Task>[],
    this.completedTaskList = const <Task>[],
  });

  @override
  List<Object> get props => [
        pendingTaskList,
        removedTaskList,
        favoriteTaskList,
        completedTaskList,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTaskList': pendingTaskList.map((x) => x.toMap()).toList(),
      'removedTaskList': removedTaskList.map((x) => x.toMap()).toList(),
      'favoriteTaskList': favoriteTaskList.map((x) => x.toMap()).toList(),
      'completedTaskList': completedTaskList.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTaskList:
          List<Task>.from(map['pendingTaskList']?.map((x) => Task.fromMap(x))),
      removedTaskList:
          List<Task>.from(map['removedTaskList']?.map((x) => Task.fromMap(x))),
    );
  }
}
