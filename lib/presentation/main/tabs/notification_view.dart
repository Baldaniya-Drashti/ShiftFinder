import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/string_constant.dart';

@RoutePage(name: 'NotificationView')
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      // child: Text("NOTIFICATION VIEW"),
      child: Column(
        children: [
          Text(StringConstant.underDevelopment),
        ],
      ),
    );
  }
}

