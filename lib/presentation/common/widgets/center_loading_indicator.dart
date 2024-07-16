import 'package:flutter/material.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CenterLoadingIndicator extends StatelessWidget {
  const CenterLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    );
  }
}

// Material(
//       color: AppColors.black.withOpacity(0.3),
//       child: Center(
//         child: Container(
//           height: getSize(100),
//           width: getSize(100),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           alignment: Alignment.center,
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
//           ),
//         ),
//       ),
//     );
