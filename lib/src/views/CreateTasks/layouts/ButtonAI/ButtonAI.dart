import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

import '../../../../shared/utils/AI/ConfigureAI.dart';
import '../../../../widgets/Button/Button.dart';
import '../../utils/generateBrain.dart';

class Buttonai extends StatelessWidget {
  ConfigureAI configureAI = ConfigureAI();
  Rx<CreateTasksState> task;
  String ref;

  Buttonai(
      {super.key, required this.task, required this.ref});

  @override
  Widget build(BuildContext context) {
    return
      Button(
        disable: ref == "",
      style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(BorderSide(
          color: Colors.blueAccent
        )),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)
      ),
      contentbtn: Wrap(
        children: [
          Text(
            "Generar",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 8.0),
          Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 15,)
        ],
      ),
      click: () {
        generateBrain(configureAI.model, ref, (value) {
          task.update((tk) {
            if (tk != null){
              if(ref == task.value.title_task){
                tk.title_task = value;
              }
              else if(ref == task.value.description){
                tk.description = value;
              }
            }
          });
        });
      },
    );
  }
}
