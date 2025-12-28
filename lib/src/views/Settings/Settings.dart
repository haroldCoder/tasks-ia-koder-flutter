import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionInternet.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premiumUser.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:get/get.dart';
import '../../widgets/MarkDown/Markdown.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonPremium.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonGoogle.dart';

class Settings extends ConsumerWidget {
  Settings({super.key});
  final ConfigAppState configAppState = Get.find<ConfigAppState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final user = authState.currentUser;
    final isUserPremium = ref.watch(premiumUserProvider);

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFF000000),
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
                    SizedBox(height: 20),
                    Container(
                      height: 20,
                      padding: EdgeInsets.only(right: 8),
                      child: ConnectionInternet(
                        decoration: TextDecoration.none,
                        font: 'rubik',
                      ),
                    ),
                    SizedBox(height: 20),
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
                                  titleSettings,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: user?.photoURL == null
                                    ? AssetImage('lib/assets/lion.jpeg')
                                    : NetworkImage(user!.photoURL!) as ImageProvider,
                              ),
                            ],
                          )),
                          Align(
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
                                      username,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 5),
                                  ),
                                  Text(
                                    user?.displayName ?? "",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                          Align(
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
                                        email,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5),
                                    ),
                                    Text(
                                      user?.email ?? "",
                                      style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 17),
                                    ),
                                  ])),
                          Row(
                            children: [
                              Text(
                                mode,
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
                        if (!isUserPremium)
                          Buttonpremium(),
                        Buttongoogle()
                      ],
                    )),
                Row(
                  children: [TabBarFooter()],
                )
              ],
            )));
  }
}
