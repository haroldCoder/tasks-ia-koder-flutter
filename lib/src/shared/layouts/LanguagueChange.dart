import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/domain/constants/languagesOptions.dart';
import 'package:tasks_ia_koderx/src/domain/models/languaguesOptions_model.dart';
import 'package:tasks_ia_koderx/src/shared/enums/langs.dart';

class LanguagueChange extends StatelessWidget {
  const LanguagueChange({super.key, this.selectedBackground, this.background});
  final Color? selectedBackground;
  final Color? background;

  void changeLanguague(BuildContext context, Languages lang) {
    context.setLocale(Locale(lang.name));
  }

  @override
  Widget build(BuildContext context) {
    return ShadMenubar(
        backgroundColor: Colors.transparent,
        selectOnHover: false,
        border: ShadBorder(merge: false),
        items: [
          ShadMenubarItem(
            selectedBackgroundColor: selectedBackground ?? const Color(0xFF000000),
            backgroundColor: background ?? Colors.blueAccent,
            decoration: ShadDecoration(
                color: Colors.black,
                merge: false,
                border: ShadBorder(
                    radius: BorderRadius.circular(8),
                    top: ShadBorderSide(
                        width: .9, color: const Color(0xFFB6B6B6)),
                    bottom: ShadBorderSide(
                        width: .9, color: const Color(0xFFB6B6B6)),
                    left: ShadBorderSide(
                        width: .9, color: const Color(0xFFB6B6B6)),
                    right: ShadBorderSide(
                        width: .9, color: const Color(0xFFB6B6B6)))),
            items: languaguesOptions
                .map((ILanguaguesValues ln) => ShadContextMenuItem(
                      onPressed: () => changeLanguague(context, ln.value),
                      selectedBackgroundColor: Color(0xFF292929),
                      decoration: ShadDecoration(merge: false),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          ln.layout,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
                .toList(),
            child: Icon(
              Icons.translate,
              color: Colors.white,
              size: 23,
            ),
          )
        ]);
  }
}
