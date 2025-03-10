import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Bargraphictasks extends StatelessWidget {
  const Bargraphictasks(
      {super.key, required this.task_completed, required this.task_pending});
  final int task_completed;
  final int task_pending;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white38)),
        height: 200,
        child: Column(
          children: [
            Align(
              child: Text(
                "Estado de tareas",
                style: TextStyle(color: Colors.white38),
              ),
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: BarChart(BarChartData(
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                      toY: task_completed.toDouble(),
                      color: Colors.green,
                      width: 40,
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: task_completed + 2,
                          color: Colors.green)),
                ], showingTooltipIndicators: [
                  0
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: task_pending.toDouble(),
                      color: Colors.white10,
                      width: 40,
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: task_pending + 2,
                          color: Colors.white)),
                ], showingTooltipIndicators: [
                  0
                ]),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text("Completadas",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white));
                        case 1:
                          return Text("Pendientes",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white));
                        default:
                          return Text("");
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(color: Colors.white30, fontSize: 12),
                      );
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
            )))
          ],
        ));
  }
}
