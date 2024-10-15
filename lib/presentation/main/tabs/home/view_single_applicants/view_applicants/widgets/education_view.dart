import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class EducationView extends StatelessWidget {
  const EducationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: 'Education',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          textColor: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          height: getSize(8),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(14),
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.asset(
                PngImageConstants.education,
                height: getSize(25),
                width: getSize(45),
              ),
              SizedBox(
                width: getSize(15),
              ),
              Image.asset(
                PngImageConstants.line,
                height: getSize(80),
              ),
              SizedBox(
                width: getSize(15),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: 'Program Completed',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: getSize(5),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Completed in - ",
                        style: TextStyle(fontSize: 8),
                        children: [
                          TextSpan(text: "2010",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500))
                        ]
                      ),
                    ),
                    SizedBox(
                      height: getSize(5),
                    ),
                    BaseText(
                      text: 'Veritex Community Inst.of USA',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              //  Icon(Icons.arrow_forward_rounded)
            ],
          ),
        ),
      ],
    );
  }
}
