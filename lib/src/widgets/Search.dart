import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/lang/home/lang.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, this.margin = 0});
  final double margin;
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: widget.margin),
        foregroundDecoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.white54,
          ),
          Expanded(
            child: SizedBox(
              height: 28,
              child: Theme(data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.blueAccent
                )
              ), child: SearchBar(
                textInputAction: TextInputAction.done,
                hintText: search,
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                hintStyle: MaterialStateProperty.all(TextStyle(
                    color: Colors.white54,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    fontFamily: 'inter',
                    decorationColor: Colors.white54
                )
                ),
                textStyle: MaterialStateProperty.all(TextStyle(
                    color: Colors.white
                )),
              ),)
            ),
          )
        ]));
  }
}
