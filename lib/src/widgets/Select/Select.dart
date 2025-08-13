import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Select extends StatelessWidget {
  const Select(
      {super.key,
      required this.options,
      this.placeholder,
      this.decoration,
      required this.onchange,
      this.initialValue,
      this.colorletter,
      this.trailing,
      this.enabled = true});
  final Map options;
  final Widget? placeholder;
  final ShadDecoration? decoration;
  final Function(String value) onchange;
  final String? initialValue;
  final Color? colorletter;
  final Widget? trailing;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180),
      child: ShadSelect<String>(
        enabled: enabled && true,
        trailing: trailing,
        initialValue: initialValue,
        placeholder: this.placeholder,
        decoration: decoration,
        options: [
          ...this.options.entries.map<Widget>(
              (e) => ShadOption(value: e.key, child: Text(e.value))),
        ],
        selectedOptionBuilder: (context, value) => Text(value, style: TextStyle(color: this.colorletter),),
        onChanged: (String? value) {
          if (value != null) {
            onchange(value);
          }
        },
      ),
    );
  }
}
