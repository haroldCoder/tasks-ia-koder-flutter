import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/task_providers.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/templates/BarGraphicVisited/BarGraphicVisited.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/widgets/MarkDown/Markdown.dart';
import 'package:tasks_ia_koderx/src/templates/BarGraphicTasks/BarGraphicTasks.dart';

class Statistics extends ConsumerWidget {
  const Statistics({super.key, required this.color_app});
  final Color color_app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskUseCasesProvider);
    final task_completed =
        taskState.tasks.where((tk) => tk.completed == 1).length;
    final task_pending = taskState.tasks.where((tk) => tk.completed == 0).length;

    return Scaffold(
        backgroundColor: color_app,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              spacing: 15,
              children: [
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  child: const TabMain(),
                ),
                const ConnectionInternet(
                  decoration: TextDecoration.none,
                  font: 'rubik',
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        spacing: 20,
                        children: [
                          Container(
                              alignment: Alignment.topRight,
                              child: const Markdown(version: "Beta")),
                          SizedBox(
                              height: 200,
                              child: Bargraphictasks(
                                  task_completed: task_completed,
                                  task_pending: task_pending)),
                          SizedBox(height: 200, child: Bargraphicvisited())
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
