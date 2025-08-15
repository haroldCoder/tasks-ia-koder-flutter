import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/templates/BarGraphicVisited/BarGraphicVisited.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/widgets/MarkDown/Markdown.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/templates/BarGraphicTasks/BarGraphicTasks.dart';

class Statistics extends StatelessWidget {
  Statistics({super.key, required this.color_app});
  int task_pending = 0;
  int task_completed = 0;
  TaskController task_controller = Get.put(TaskController());
  Rx<Color> color_app;

  @override
  Widget build(BuildContext context) {
    task_completed =
        task_controller.tasks.where((tk) => tk.complete == 1).length;
    task_pending = task_controller.tasks.where((tk) => tk.complete == 0).length;

    return Scaffold(
        backgroundColor: color_app.value,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              spacing: 15,
              children: [
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: TabMain(),
                ),
                Container(
                  height: 20,
                  padding: EdgeInsets.only(right: 8),
                  child: ConnectionInternet(
                    decoration: TextDecoration.none,
                    font: 'rubik',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        spacing: 20,
                        children: [
                          Container(
                              child: Container(
                                  alignment: Alignment.topRight,
                                  child: Markdown(version: "Beta"))),
                          Container(
                              height: 200,
                              child: Bargraphictasks(
                                  task_completed: task_completed,
                                  task_pending: task_pending)),
                          Container(height: 200, child: Bargraphicvisited())
                        ],
                      ),
                    )),
              ],
            ),
            Row(children: [TabBarFooter()])
          ],
        )));
  }
}
