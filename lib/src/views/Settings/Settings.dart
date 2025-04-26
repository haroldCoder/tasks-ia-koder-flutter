import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/loginUser.dart';
import 'package:tasks_ia_koderx/src/shared/utils/subscription_request.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:get/get.dart';
import '../../widgets/MarkDown/Markdown.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final ConfigAppState configAppState = Get.find<ConfigAppState>();
  AuthService authService = AuthService();
  LoginUser loginUser = LoginUser();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black54,
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 65,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration:
                          BoxDecoration(color: Colors.black, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 1),
                        ),
                      ]),
                      child: TabMain(),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                      child: Column(
                        spacing: 20,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Markdown(version: "Beta"),
                          ),
                          Container(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.only(bottom: 5, left: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.white54))),
                                child: Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Obx(() {
                                return CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      authService.current_user.value == null
                                          ? AssetImage('lib/assets/lion.jpeg')
                                          : NetworkImage(authService
                                              .current_user.value!.photoURL!),
                                );
                              })
                            ],
                          )),
                          Obx(() {
                            return Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.white60))),
                                      child: Text(
                                        "Username",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5),
                                    ),
                                    Text(
                                      authService.current_user.value != null
                                          ? authService
                                              .current_user.value!.displayName!
                                              .toString()
                                          : "",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 17),
                                    ),
                                  ],
                                ));
                          }),
                          Obx(() {
                            return Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.white60))),
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 5),
                                      ),
                                      Text(
                                        authService.current_user.value != null
                                            ? authService
                                                .current_user.value!.email!
                                                .toString()
                                            : "",
                                        style: TextStyle(
                                            color: Colors.white38,
                                            fontSize: 17),
                                      ),
                                    ]));
                          }),
                          Row(
                            children: [
                              Text(
                                "Modo: ",
                                style: TextStyle(color: Colors.white30),
                              ),
                              Obx(() => ShadSwitch(
                                  onChanged: (value) {
                                    configAppState.color_theme.value ==
                                            Colors.black
                                        ? configAppState
                                            .changeColorThemeApp(Colors.white)
                                        : configAppState
                                            .changeColorThemeApp(Colors.black);
                                  },
                                  duration: Duration(milliseconds: 500),
                                  value: configAppState.color_theme.value ==
                                      Colors.black))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 80,
                    right: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      spacing: 5,
                      children: [
                        Button(
                          contentbtn: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                gradient: LinearGradient(
                                  colors: [Colors.blueAccent, Colors.white12],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )),
                            child: Text("Cambiar a premium",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          style: ButtonStyle(
                            alignment: Alignment.topLeft,
                            padding:
                                MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                    EdgeInsets.all(0)),
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          click: () {
                            SubscriptionRequests().createSubscription();
                          },
                        ),
                        Button(
                            click: () async {
                              if (!authService.logged.value) {
                                await authService.SignInWithGoogle();
                                await loginUser.login(
                                    authService.current_user.value?.email,
                                    authService.current_user.value?.phoneNumber,
                                    authService
                                            .current_user.value?.displayName ??
                                        "");
                              } else {
                                await authService.logoutGoogle();
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.9,
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.white10)),
                            contentbtn: Obx(() {
                              return !authService.logged.value
                                  ? Image.asset(
                                      'lib/assets/googleicon.png',
                                      width: 30,
                                    )
                                  : Text(
                                      "Cerrar sesion",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    );
                            })),
                      ],
                    )),
                Row(
                  children: [TabBarFooter()],
                )
              ],
            )));
  }
}
