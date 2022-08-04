part of 'tasks_bloc.dart';

class TasksState extends Equatable {

  final List<Task> taskList;

  const TasksState(
    {this.taskList = const <Task> []}
  );
  
  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}
