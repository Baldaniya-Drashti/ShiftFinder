import 'package:flutter/material.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class OfferRevokedView extends StatelessWidget {
  const OfferRevokedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: 'Offer Revoked',
      fontSize: 12,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w600,
    );
  }
}
