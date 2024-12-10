import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/notification/notification_bloc.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'NotificationView')
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationBloc>(),
      child: _NotificationListView(),
    );
  }
}

class _NotificationListView extends StatelessWidget {
  const _NotificationListView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) => _NotificationTile(),
      separatorBuilder: (context, index) => Gap(16),
      itemCount: 5,
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(PngImageConstants.homeAppBarLogo,
                    height: 35, width: 35),
                Gap(10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BaseText(
                              text: "CT Technologist",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              textColor: AppColors.black.withOpacity(0.7),
                            ),
                          ),
                          BaseText(
                            text: "Just now",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      Gap(4),
                      BaseText(
                        text: "Louis Vuitton Pvt. Ltd.",
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        textColor: AppColors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(10),
            Material(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.scaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BaseText(
                  text:
                      "Your shift is going to be start in 2 min please submit your clock in time.",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
