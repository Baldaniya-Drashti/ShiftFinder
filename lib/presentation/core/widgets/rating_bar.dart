import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'dart:math' as math;

class RatingBar extends StatefulWidget {
  final int starCount;
  final int initialRating;
  final ValueSetter<int> onChanged;

  const RatingBar({
    super.key,
    this.starCount = 5,
    this.initialRating = 0,
    required this.onChanged,
  });

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late ValueNotifier<int> _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = ValueNotifier<int>(widget.initialRating);
  }

  @override
  void didUpdateWidget(covariant RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(math.max(0, (widget.starCount * 2) - 1),
          (initialIndex) {
        final int index = initialIndex ~/ 2;
        if (initialIndex.isEven) {
          return GestureDetector(
            onTap: () {
              _currentRating.value = index + 1;
              widget.onChanged(_currentRating.value);
            },
            child: ValueListenableBuilder(
              valueListenable: _currentRating,
              builder: (context, value, _) => SvgPicture.asset(
                index < _currentRating.value
                    ? SvgImageConstant.starFilled
                    : SvgImageConstant.starOutlined,
                height: 35,
                width: 35,
              ),
            ),
          );
        } else {
          return Gap(getSize(16));
        }
      }),
    );
  }
}
