import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:under/feature/api/data_base.dart';
import 'package:under/feature/home/injector.dart';
import 'package:under/routers.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBase.initDatabase();
  runApp(const RootWidget());
}

class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  RootWidgetState createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  @override
  void initState() {
    super.initState();
    Injector.init();
    Injector.initReducer();
    Injector.initHomeModule();
    Injector.initSignInModule();
  }

  @override
  void dispose() {
    Injector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: Routers.allRouters(),
    );
  }
}
