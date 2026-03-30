// ignore_for_file: prefer_const_constructors

import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CustomKeyboardConfig extends StatelessWidget {
  final List<FocusNode> focusNode;
  const CustomKeyboardConfig({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      actions: List.generate(
        focusNode.length,
        (index) => KeyboardActionsItem(
          focusNode: focusNode[index],
          displayArrows: false,
          onTapAction: () {
            AppFocus.unfocus(context);
          },
        ),
      ),
    );
  }
}
