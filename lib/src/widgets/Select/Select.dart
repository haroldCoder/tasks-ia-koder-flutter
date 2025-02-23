import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Select extends StatelessWidget {
  const Select(
      {super.key,
      required this.options,
      required this.placeholder,
      this.decoration,
      required this.onchange});
  final Map options;
  final Widget placeholder;
  final ShadDecoration? decoration;
  final ValueChanged<String?>? onchange;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180),
      child: ShadSelect<String>(
        placeholder: this.placeholder,
        decoration: decoration,
        options: [
          ...this.options.entries.map<Widget>(
              (e) => ShadOption(value: e.key, child: Text(e.value))),
        ],
        selectedOptionBuilder: (context, value) => Text(this.options[value]!),
        onChanged: onchange,
      ),
    );
  }
}
