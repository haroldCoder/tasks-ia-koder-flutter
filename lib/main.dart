import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/preferencesApp.dart';
import 'package:tasks_ia_koderx/src/home.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/views/Settings/Settings.dart';
import 'package:tasks_ia_koderx/src/views/Statistics/Statistics.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/UploadTask.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks.dart';
import 'package:tasks_ia_koderx/src/views/createTasks.dart';
import 'src/screen_splash.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConfigAppState());
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env["FIREBASE_API_KEY"].toString(),
      appId: dotenv.env["FIREBASE_APP_ID"].toString(),
      messagingSenderId: dotenv.env["FIREBASE_MESSAGINGSENDERING"].toString(),
      projectId: dotenv.env["FIREBASE_PROJECT_ID"].toString(),
      storageBucket: dotenv.env["FIREBASE_BUCKET"].toString(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigAppState configAppState = Get.find<ConfigAppState>();
    final GoRouter router = GoRouter(
        redirect: (context, state) {
          Get.put(TaskController());
          Get.find<TaskController>().clearSelectTasks();
        },
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                SplashScreen(
                  color_app: configAppState.color_theme,
                ),
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: SplashScreen(
                    color_app: configAppState.color_theme,
                  ));
            },
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: MyHomePage(
                    title: "Tasks App Koderx",
                    color_app: configAppState.color_theme,
                  ));
            },
          ),
          GoRoute(
            path: '/create-tasks',
            builder: (context, state) =>
                Createtasks(
                  color_app: configAppState.color_theme,
                ),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: Createtasks(color_app: configAppState.color_theme));
            },
          ),
          GoRoute(
            path: '/check',
            builder: (context, state) =>
                Completedtasks(
                  color_app: configAppState.color_theme,
                ),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: Completedtasks(
                    color_app: configAppState.color_theme,
                  ));
            },
          ),
          GoRoute(
            path: '/statistics',
            builder: (context, state) =>
                Statistics(
                  color_app: configAppState.color_theme,
                ),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: Statistics(
                    color_app: configAppState.color_theme,
                  ));
            },
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => Settings(),
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: Settings());
            },
          ),
          GoRoute(
            path: '/upload-task',
            builder: (context, state) {
              final data = state.extra as TasksInterface;
              return Uploadtask(
                  data: data);
            },
            pageBuilder: (context, state) {
              final data = state.extra as TasksInterface;
              return CustomTransitionPage(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                  child: Uploadtask(
                      data: data
                  ));
            },
          )
        ]);

    return ShadApp.custom(
      appBuilder: (BuildContext context){
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: preferencesApp(context),
          builder: (context, child) {
            return ShadAppBuilder(child: child!);
          }
        );
      },
    );
  }
}
