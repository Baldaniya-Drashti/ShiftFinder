// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/home/home_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/core/employer_home/employer_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class StackedImage extends StatelessWidget {
  final int index;
  final bool isTotalApplicants;
  const StackedImage({
    super.key,
    required this.index,
    this.isTotalApplicants = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<ApplicationProfile> imageList = isTotalApplicants
            ? (state.employerDashboardList[index].total_application_profiles ??
                [])
            : (state.employerDashboardList[index].total_proposal_profiles ??
                []);

        List<double> imagePosition = [0, 13, 26, 39, 52, 65];
        return Container(
          width: getSize(100),
          height: getSize(30),
          // color: Colors.yellow,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < imageList.length; i++)
                if (i <= 5)
                  Positioned(
                    left: imagePosition[i],
                    child: Container(
                      width: getSize(30),
                      height: getSize(30),
                      decoration: BoxDecoration(
                        color: AppColors.authBlack,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: getSize(2),
                        ),
                        image: DecorationImage(
                          opacity: (imageList.length > 6 && i == 5) ? 0.4 : 100,
                          image: NetworkImage(
                            imageList[i].profile ?? "",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              if (imageList.length > 6)
                Align(
                  alignment: Alignment.centerRight,
                  child: BaseText(
                    text: "${imageList.length - 6}+",
                    fontSize: 9,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
