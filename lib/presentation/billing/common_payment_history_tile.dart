import 'package:flutter/material.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class CommonPaymentHistoryTile extends StatelessWidget {
  const CommonPaymentHistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SpecialityInfo(),
        ],
      ),
    );
  }
}

class _SpecialityInfo extends StatelessWidget {
  const _SpecialityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(PngImageConstants.nurse2),
    );
  }
}
