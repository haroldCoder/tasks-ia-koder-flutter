import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/home.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks.dart';
import 'package:tasks_ia_koderx/src/views/createTasks.dart';
import 'src/screen_splash.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
        redirect: (context, state) {
         Get.find<TaskController>().clearSelectTasks();
        },
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => SplashScreen(),
            pageBuilder: (context, state) {
              return NoTransitionPage(child: SplashScreen());
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
                  child: MyHomePage(title: "Tasks App Koderx"));
            },
          ),
          GoRoute(
            path: '/create-tasks',
            builder: (context, state) => Createtasks(),
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
                  child: Createtasks());
            },
          ),
          GoRoute(
            path: '/check',
            builder: (context, state) => Completedtasks(),
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
                  child: Completedtasks());
            },
          )
        ]);

    return ShadApp.materialRouter(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: router,
      materialThemeBuilder: (context, baseTheme) {
        return ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          textTheme: baseTheme.textTheme.copyWith(
            titleLarge:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
          ),
          cardTheme: CardTheme(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true, // Habilita el fondo
            fillColor: Colors.transparent, // Color de fondo
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            hintStyle: TextStyle(color: Colors.grey[500]),
            labelStyle: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
