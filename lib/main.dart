import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/home.dart';
import 'package:tasks_ia_koderx/src/views/createTasks.dart';
import 'src/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(initialLocation: '/', routes: [
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
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
              child: MyHomePage(title: "Tasks App Koderx"));
        },
      ),
      GoRoute(
        path: '/create-tasks',
        builder: (context, state) => Createtasks(),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              child: Createtasks());
        },
      )
    ]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: router,
    );
  }
}
