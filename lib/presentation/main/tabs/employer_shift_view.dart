import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';

@RoutePage(name: 'EmployerShiftView')
class EmployerShiftView extends StatelessWidget {
  const EmployerShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: Text("Employer Shift View"),
      child: Text(StringConstant.underDevelopment),
    );
  }
}
