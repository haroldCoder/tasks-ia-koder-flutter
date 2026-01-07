import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonPremium.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonGoogle.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/Connection_internet.dart';
import 'package:tasks_ia_koderx/src/shared/utils/auth_service.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premium_user.dart';
import 'package:tasks_ia_koderx/src/widgets/AppBar/tabMain.dart';
import 'package:tasks_ia_koderx/src/widgets/MarkDown/Markdown.dart';
import 'package:tasks_ia_koderx/src/widgets/Navigation/tabBarFooter.dart';

class Settings extends ConsumerWidget {
  Settings({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final user = authState.currentUser;
    final isUserPremium = ref.watch(premiumUserProvider);
    final ConfigAppState configAppState = ref.watch(configAppProvider);
    final configAppController = ref.watch(configAppProvider.notifier);

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
                              ShadSwitch(
                                  onChanged: (value) {
                                    configAppState.colorTheme ==
                                            Colors.black
                                        ? configAppController
                                            .changeColorThemeApp(Colors.white)
                                        : configAppController
                                            .changeColorThemeApp(Colors.black);
                                  },
                                  duration: Duration(milliseconds: 500),
                                  value: configAppState.colorTheme.value ==
                                      Colors.black)
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
