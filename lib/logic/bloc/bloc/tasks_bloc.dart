import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<TasksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
