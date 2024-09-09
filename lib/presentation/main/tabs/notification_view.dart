import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';

@RoutePage(name: 'NotificationView')
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: Text("NOTIFICATION VIEW"),
      child: Text(StringConstant.underDevelopment),
    );
  }
}
