import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/NavBarPremium.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getIdUser.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/shared/class/TaskError.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/shared/class/TaskLoading.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/shared/class/TaskState.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/shared/class/TaskSuccess.dart';
import 'package:tasks_ia_koderx/src/views/UploadTask/shared/widgets/DialogUpdate.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';

class Uploadtask extends StatefulWidget {
  final TasksInterface? data;
  const Uploadtask({required this.data});

  @override
  State<Uploadtask> createState() => _UploadtaskState();
}

class _UploadtaskState extends State<Uploadtask> {
  late final String emailUser;
  final StreamController<TaskState> _streamController =
      StreamController<TaskState>();

  @override
  void initState() {
    super.initState();
    this.getEmailUserMeth();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getEmailUserMeth() async {
    this.emailUser = await getEmailUser();
  }

  void UploadTaskServer() async {
    _streamController.add(TaskLoading());
    GetIdUser res = GetIdUser();
    var userId = await res.buildRequest(emailUser);

    var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
        .request(method: HttpMethod.post, endpoint: "v1/tasks/tasks", body: {
      "title": widget.data!.title,
      "description": widget.data!.description,
      "priority": widget.data!.priority,
      "completed": widget.data!.completed,
      "userId": userId,
      "id_task_app": widget.data!.id
    });

    if (response["httpStatus"] == 201) {
      _streamController.add(TaskSuccess("Tarea subida con éxito"));
    } else {
      _streamController.add(TaskError("Ocurrio un error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Navbarpremium(),
                  Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data!.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(widget.data!.description,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'italic'))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: StreamBuilder<TaskState>(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final state = snapshot.data;
                            if (state is TaskLoading) {
                              return Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              );
                            } else if (state is TaskSuccess) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showDialog(
                                  context: context,
                                  builder: (builder) =>
                                      DialogUpdate(text: state.message),
                                ).then((_){
                                  context.pop();
                                });
                              });
                            } else if (state is TaskError) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showDialog(
                                  context: context,
                                  builder: (builder) =>
                                      DialogUpdate(text: state.message),
                                );
                              });
                            }
                          }
                          return Column(
                            spacing: 20,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.white10,
                                child: ClipOval(
                                  child: Image.asset(
                                    "lib/assets/cloud.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Button(
                                click: UploadTaskServer,
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.lightBlueAccent),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ))),
                                contentbtn: Text(
                                  "Subir a la cloud",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            )));
  }
}
