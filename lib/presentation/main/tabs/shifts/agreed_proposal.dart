// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/main/tabs/shifts/multi_agreed_shift.dart';
import 'package:shift/presentation/main/tabs/shifts/single_agreed_shift.dart';

@RoutePage(name: 'AgreedProposal')
class AgreedProposal extends StatelessWidget {
  int userId;
  int postId;
  HealthcarePostDTO post;
  AgreedProposal(
      {super.key,
      required this.post,
      required this.userId,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    return (post.shift_detail?.shift_type == 1)
        ? SingleAgreedShift()
        : MultiAgreedShift();
  }
}
