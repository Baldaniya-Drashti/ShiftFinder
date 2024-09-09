import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';

@RoutePage(name: 'HistoryView')
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: Text("HISTORY VIEW"),
      child: Text(StringConstant.underDevelopment),
    );
  }
}
