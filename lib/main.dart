import 'package:bloc_finals_exam/logic/bloc/bloc/tasks_bloc.dart';
import 'package:bloc_finals_exam/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_router.dart';
import 'app_themes.dart';
import 'screens/tabs_screen.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  // runApp(
  //   HydratedBlocOverrides.runZoned(() => MyApp(appRouter: AppRouter()), storage: await storage),
  // );
  HydratedBlocOverrides.runZoned(
  () => runApp(MyApp(appRouter: AppRouter(),)),
  storage: await storage,
);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (_) => TasksBloc()..add(AddTask(task: Task(title: 'First Title', description: 'First Description'))),
      child: MaterialApp(
        title: 'BloC Tasks App',
        theme: AppThemes.appThemeData[AppTheme.lightMode],
        home: const TabsScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
