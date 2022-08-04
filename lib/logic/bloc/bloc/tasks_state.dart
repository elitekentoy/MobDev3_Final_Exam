// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> taskList;

  const TasksState({this.taskList = const <Task>[]});

  @override
  List<Object> get props => [taskList];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskList': taskList.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      taskList: List<Task>.from(map['taskList']?.map((x) => Task.fromMap(x))),
    );
  }
}
