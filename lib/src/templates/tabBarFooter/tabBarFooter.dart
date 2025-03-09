import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';

class TabBarFooter extends StatelessWidget {
  TabBarFooter({super.key});
  String font_family = "Roboto";

  @override
  Widget build(BuildContext context) {
    String currentPath = GoRouterState.of(context).uri.path.toString();

    goToHome(){
      Future.microtask(() => context.push("/home"));
    }

    goToCompletedTasks(){
      Future.microtask(() => context.push("/check"));
    }

    goToStatics(){
      Future.microtask(() => context.push("/statistics"));
    }

    goToSettings(){
      Future.microtask(() => context.push("/settings"));
    }

    return Expanded(
        child: Stack(children: [
      Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Button(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                        click: () {
                          goToHome();
                        },
                        contentbtn: Column(
                          spacing: 7,
                          children: [
                            Icon(
                              Icons.home,
                              size: 25,
                              color: currentPath == "/home"
                                  ? Colors.blueAccent
                                  : Color(0xF0393939),
                            ),
                            Text("Home",
                                style: TextStyle(
                                    fontFamily: this.font_family,
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: currentPath == "/home"
                                        ? Colors.blueAccent
                                        : Color(0xF0393939)))
                          ],
                        ))),
                Flexible(
                    flex: 2,
                    child: Button(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                        click: () {
                          goToCompletedTasks();
                        },
                        contentbtn: Column(
                          spacing: 7,
                          children: [
                            Icon(Icons.check_circle_outline_rounded,
                                size: 25,
                                color: currentPath == "/check"
                                    ? Colors.blueAccent
                                    : Color(0xF0393939)),
                            Text("Completado",
                                style: TextStyle(
                                    fontFamily: this.font_family,
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: currentPath == "/check"
                                        ? Colors.blueAccent
                                        : Color(0xF0393939)))
                          ],
                        ))),
                Flexible(
                    flex: 2,
                    child: Button(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                        click: () {
                          goToSettings();
                        },
                        contentbtn: Column(
                          spacing: 7,
                          children: [
                            Icon(Icons.equalizer,
                                size: 25,
                                color: currentPath == "/statistics"
                                    ? Colors.blueAccent
                                    : Color(0xF0393939)),
                            Text("Estadisticas",
                                style: TextStyle(
                                    fontFamily: this.font_family,
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: currentPath == "/statistics"
                                        ? Colors.blueAccent
                                        : Color(0xF0393939)))
                          ],
                        ))),
                Flexible(
                    flex: 3,
                    child: Button(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets
                                .zero,
                            minimumSize: Size(0,
                                0),
                            tapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,
                            backgroundColor: Colors
                                .transparent,
                            elevation: 0),
                        click: () {
                          goToSettings();
                        },
                        contentbtn: Column(
                      spacing: 7,
                      children: [
                        Icon(Icons.settings,
                            size: 25,
                            color: currentPath == "/settings"
                                ? Colors.blueAccent
                                : Color(0xF0393939)),
                        Text("Configuraciones",
                            style: TextStyle(
                                fontFamily: this.font_family,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                color: currentPath == "/settings"
                                    ? Colors.blueAccent
                                    : Color(0xF0393939)))
                      ],
                    )))
              ],
            ),
          ))
    ]));
  }
}
