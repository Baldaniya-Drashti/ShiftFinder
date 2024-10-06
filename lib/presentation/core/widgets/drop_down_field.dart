import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/svg_image_constants.dart';

class DropDownItem<T> {
  final Widget? icon;
  String label;
  T value;

  DropDownItem({required this.label, required this.value, this.icon});
}

class CommonDropDownField<T> extends StatefulWidget {
  final List<DropDownItem<T>> items;
  final String hint;
  final String label;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T>? fieldSubmitted;
  final FocusNode? focus;
  final ValueChanged<T?> onChanged;
  final T? value;
  final InputDecoration? decoration;
  final bool? filled;
  final Color? fillColor;
  final bool dataLoadedSuccess;

  const CommonDropDownField({
    required this.items,
    required this.onChanged,
    this.hint = "",
    this.validator,
    this.fieldSubmitted,
    this.focus,
    this.value,
    this.label = "",
    this.decoration,
    super.key,
    this.filled = true,
    this.fillColor,
    this.dataLoadedSuccess = false,
  });

  @override
  State<CommonDropDownField<T>> createState() => _CommonDropDownFieldState<T>();
}

class _CommonDropDownFieldState<T> extends State<CommonDropDownField<T>> with AfterLayoutMixin {
  late final FocusNode _focus;
  final _controller = TextEditingController();
  final ValueNotifier<bool> _isOptionVisible = ValueNotifier(false);
  final _scrollController = ScrollController();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  final ValueNotifier<DropDownItem<T>?> _selectedItem = ValueNotifier(null);

  @override
  void initState() {
    _focus = widget.focus ?? FocusNode();
    _selectedItem.addListener(_selectedItemListener);
    if (widget.value != null) {
      _selectedItem.value = widget.items.firstWhere((element) => element.value == widget.value);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonDropDownField<T> oldWidget) {
    if (widget.value != null) {
      _selectedItem.value = widget.items.firstWhere((element) => element.value == widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterFirstLayout() {
    _focus.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focus.removeListener(_focusListener);
    _selectedItem.removeListener(_selectedItemListener);
    super.dispose();
  }

  void _focusListener() {
    if (_focus.hasPrimaryFocus) {
      _isOptionVisible.value = true;
      _key.currentState?.reset();
    } else {
      _isOptionVisible.value = false;
      _scrollController.jumpTo(0);
    }
  }

  void _selectedItemListener() {
    if (_selectedItem.value != null) {
      Timer.run(() => _controller.text = _selectedItem.value!.label);
    }
  }

  void _onOptionSelected(DropDownItem<T> item) {
    _isOptionVisible.value = false;
    widget.onChanged(item.value);
    _selectedItem.value = item;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const Gap(8),
        ],
        ValueListenableBuilder<DropDownItem<T>?>(
          valueListenable: _selectedItem,
          builder: (context, value, _) {
            return TextFormField(
              key: _key,
              controller: _controller,
              readOnly: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (_) => widget.validator?.call(widget.value),
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600),
              decoration: (widget.decoration ?? const InputDecoration()).copyWith(
                filled: widget.filled,
                fillColor: widget.fillColor,
                hintText: widget.hint,
                hintStyle: theme.textTheme.bodyLarge,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 12),
                ),
                contentPadding: EdgeInsets.zero,
                prefixIcon: value?.icon == null ? null : Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: value?.icon),
                suffixIcon: ActionIcon(
                  onPressed: () => widget.dataLoadedSuccess ? _isOptionVisible.value = !_isOptionVisible.value : null,
                  icon: ValueListenableBuilder<bool>(
                    valueListenable: _isOptionVisible,
                    builder: (context, isVisible, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        transform: Matrix4.rotationZ(isVisible ? pi / 1 : 0),
                        transformAlignment: Alignment.center,
                        child: SvgPicture.asset(
                          SvgImageConstant.downArrow,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isOptionVisible,
          builder: (context, isVisible, child) {
            return SizedBox(
              height: isVisible ? 160 : null,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  return true;
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Material(
                    elevation: 0,
                    //shadowColor: context.colorScheme.,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      side: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      height: isVisible ? 200 : 0,
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(padding: const EdgeInsets.only(top: 0, bottom: 16)),
                        child: PrimaryScrollController(
                          controller: _scrollController,
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: widget.items.length,
                              itemBuilder: (context, index) {
                                final item = widget.items[index];
                                return ListTile(
                                  dense: true,
                                  leading: item.icon,
                                  horizontalTitleGap: 0,
                                  title: Text(item.label,
                                      style: item.value == _selectedItem.value?.value
                                          ? theme.textTheme.bodyLarge!.copyWith(
                                              color: Colors.pink,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            )
                                          : theme.textTheme.bodyLarge!.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.yellow,
                                            )),
                                  onTap: () => _onOptionSelected(item),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout());
  }

  void afterFirstLayout();
}

class ActionIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final VisualDensity? visualDensity;
  final String? tooltip;
  final double? iconSize;
  final double? splashRadius;

  const ActionIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.visualDensity = VisualDensity.compact,
    this.tooltip,
    this.iconSize,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      visualDensity: visualDensity,
      tooltip: tooltip,
      iconSize: iconSize,
      splashRadius: splashRadius,
    );
  }
}
