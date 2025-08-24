import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/Button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/main/PresentationCases.dart';

enum fontFamilyButton {
  roboto,
  Almendra,
  Caveat,
  JosefinSans,
  MysteryQuest,
  Oswald
}

@widgetbook.UseCase(name: 'Default', type: Button)
Widget buttonDefaultUseCase(BuildContext context) {
  return PresentationCases(
    child: Button(
      contentbtn: Text(
        context.knobs.string(
          label: 'Button Text',
          initialValue: 'Click Me',
          description: 'Text displayed on the button',
        ),
      ),
      disable: context.knobs.boolean(
        label: 'Disable',
        initialValue: false,
        description: 'Disable the button',
      ),

      click: () => print("Button clicked"),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.knobs.color(
          label: 'Background Color',
          initialValue: const Color(0xFF000000),
          initialColorSpace: ColorSpace.hex,
          description: 'Background color of the button',
        ),
        foregroundColor: context.knobs.color(
          label: 'Text Color',
          initialValue: const Color(0xFF0099FF),
          initialColorSpace: ColorSpace.hex,
          description: 'Text color of the button',
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.knobs.double
              .input(
                label: 'Horizontal Padding',
                initialValue: 16,
                description: 'Horizontal padding of the button',
              )
              .toDouble(),
          vertical: context.knobs.double
              .input(
                label: 'Vertical Padding',
                initialValue: 8,
                description: 'Vertical padding of the button',
              )
              .toDouble(),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: context.knobs.object.dropdown(
            label: 'Font Family',
            options: fontFamilyButton.values.map((e) => e.name.toString()).toList(),
            initialOption: fontFamilyButton.roboto.name.toString(),
            description: 'Font family of the button text',
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            context.knobs.double.slider(
              label: 'Border Radius',
              initialValue: 10,
              description: 'Border radius of the button',
              min: 0,
              max: 100,
              divisions: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
