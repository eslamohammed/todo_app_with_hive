import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/bases/BaseWidget.dart';
import 'package:todo_app/utils/routes.dart';

void main() async{
  /// Initial Hive DB
  await Hive.initFlutter();

  /// Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  /// Open box
  var box = await Hive.openBox<Task>("tasksBox");

  /// Delete data from previous day
  // ignore: avoid_function_literals_in_foreach_calls
  box.values.forEach((task) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  });

  // runApp(const MyApp());
  runApp(BaseWidget(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pretium Finanace',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      );
    }
}