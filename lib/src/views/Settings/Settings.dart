import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premiumUser.dart';
import 'package:tasks_ia_koderx/src/templates/tabBarFooter/tabBarFooter.dart';
import 'package:tasks_ia_koderx/src/templates/tabMain.dart';
import 'package:get/get.dart';
import '../../widgets/MarkDown/Markdown.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonPremium.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonGoogle.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final ConfigAppState configAppState = Get.find<ConfigAppState>();
  AuthService authService = Get.put(AuthService());
  PremiumUser isUserPremium = Get.put(PremiumUser());

  @override
  Widget build(BuildContext context) {
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
                                        username,
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
                                          email,
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
                        Obx((){
                          return !isUserPremium.isPremium.value ?
                              Buttonpremium()
                              : SizedBox.shrink();
                        }),
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
