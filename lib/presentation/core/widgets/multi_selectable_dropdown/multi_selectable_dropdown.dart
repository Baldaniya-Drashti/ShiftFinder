// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_final_fields, unnecessary_brace_in_string_interps, prefer_const_constructors, annotate_overrides, overridden_fields, prefer_initializing_formals

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/mult_select_dialog.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_chip_display.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_list_type.dart';

/// A customizable InkWell widget that opens the MultiSelectDialog
// ignore: must_be_immutable
class MultiSelectDialogField<V> extends FormField<List<V>> {
  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Style the Container that makes up the field.
  final BoxDecoration? decoration;

  /// Set text that is displayed on the button.
  final Text? buttonText;

  /// Specify the button icon.
  final Widget? buttonIcon;

  /// The text at the top of the dialog.
  final String? title;

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Overrides the default MultiSelectChipDisplay attached to this field.
  /// If you want to remove it, use MultiSelectChipDisplay.none().
  final MultiSelectChipDisplay<V>? chipDisplay;

  /// The list of selected values before interaction.
  final List<V> initialValue;
  final List<V> otherInitialValue;

  /// Fires when confirm is tapped.
  final void Function(List<V>, List<V>) onConfirm;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// Set the color of the space outside the BottomSheet.
  final Color? barrierColor;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? dialogHeight;

  /// Sets a fixed width on the dialog.
  final double? dialogWidth;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V)? colorator;

  /// Set the background color of the dialog.
  final Color? backgroundColor;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Replaces the deafult search icon when searchable is true.
  final Icon? searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the text that is typed into the search field.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /// Whether the user can dismiss the widget by tapping outside
  final bool isDismissible;

  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<List<V>>? validator;
  final FormFieldSetter<List<V>>? onSaved;
  final GlobalKey<FormFieldState>? key;
  FormFieldState<List<V>>? state;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool? isLabelPadding;
  final bool? isOptional;
  final Widget? optionalWidget;
  final bool isShowOtherValue;

  MultiSelectDialogField({
    required this.items,
    required this.onConfirm,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.chipDisplay,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.barrierColor,
    this.selectedColor,
    this.searchHint,
    this.dialogHeight,
    this.dialogWidth,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isDismissible = false,
    this.onSaved,
    this.validator,
    this.initialValue = const [],
    this.otherInitialValue = const [],
    this.autovalidateMode = AutovalidateMode.disabled,
    this.key,
    this.labelText,
    this.labelStyle,
    this.isLabelPadding = true,
    this.isOptional = false,
    this.optionalWidget,
    this.isShowOtherValue = true,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue,
            builder: (FormFieldState<List<V>> state) {
              _MultiSelectDialogFieldView<V> field =
                  _MultiSelectDialogFieldView<V>(
                      title: title,
                      items: items,
                      buttonText: buttonText,
                      buttonIcon: buttonIcon,
                      chipDisplay: chipDisplay,
                      decoration: decoration,
                      listType: listType,
                      onConfirm: onConfirm,
                      onSelectionChanged: onSelectionChanged,
                      initialValue: initialValue,
                      otherInitialValue: otherInitialValue,
                      searchable: searchable,
                      confirmText: confirmText,
                      cancelText: cancelText,
                      barrierColor: barrierColor,
                      selectedColor: selectedColor,
                      searchHint: searchHint,
                      dialogHeight: dialogHeight,
                      dialogWidth: dialogWidth,
                      colorator: colorator,
                      backgroundColor: backgroundColor,
                      unselectedColor: unselectedColor,
                      searchIcon: searchIcon,
                      closeSearchIcon: closeSearchIcon,
                      itemsTextStyle: itemsTextStyle,
                      searchTextStyle: searchTextStyle,
                      searchHintStyle: searchHintStyle,
                      selectedItemsTextStyle: selectedItemsTextStyle,
                      separateSelectedItems: separateSelectedItems,
                      checkColor: checkColor,
                      isDismissible: isDismissible,
                      labelText: labelText,
                      labelStyle: labelStyle,
                      isLabelPadding: isLabelPadding,
                      isOptional: isOptional,
                      optionalWidget: optionalWidget,
                      isShowOtherValue: isShowOtherValue);
              return _MultiSelectDialogFieldView<V>._withState(field, state);
            });
}

// ignore: must_be_immutable
class _MultiSelectDialogFieldView<V> extends StatefulWidget {
  final MultiSelectListType? listType;
  final BoxDecoration? decoration;
  final Text? buttonText;
  final Widget? buttonIcon;
  final String? title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>)? onSelectionChanged;
  final MultiSelectChipDisplay<V>? chipDisplay;
  final List<V> initialValue;
  final List<V> otherInitialValue;
  final void Function(List<V>, List<V>)? onConfirm;
  final bool? searchable;
  final Text? confirmText;
  final Text? cancelText;
  final Color? barrierColor;
  final Color? selectedColor;
  final double? dialogHeight;
  final double? dialogWidth;
  final String? searchHint;
  final Color Function(V)? colorator;
  final Color? backgroundColor;
  final Color? unselectedColor;
  final Icon? searchIcon;
  final Icon? closeSearchIcon;
  final TextStyle? itemsTextStyle;
  final TextStyle? selectedItemsTextStyle;
  final TextStyle? searchTextStyle;
  final TextStyle? searchHintStyle;
  final bool separateSelectedItems;
  final Color? checkColor;
  final bool isDismissible;
  FormFieldState<List<V>>? state;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool? isLabelPadding;
  final bool? isOptional;
  final Widget? optionalWidget;
  final bool isShowOtherValue;

  _MultiSelectDialogFieldView({
    required this.items,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.chipDisplay,
    this.initialValue = const [],
    this.otherInitialValue = const [],
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.barrierColor,
    this.selectedColor,
    this.searchHint,
    this.dialogHeight,
    this.dialogWidth,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    required this.isDismissible,
    this.labelText,
    this.labelStyle,
    this.isLabelPadding = true,
    this.isOptional = false,
    this.optionalWidget,
    this.isShowOtherValue = true,
  });

  /// This constructor allows a FormFieldState to be passed in. Called by MultiSelectDialogField.
  _MultiSelectDialogFieldView._withState(
      _MultiSelectDialogFieldView<V> field, FormFieldState<List<V>> state)
      : items = field.items,
        title = field.title,
        buttonText = field.buttonText,
        buttonIcon = field.buttonIcon,
        listType = field.listType,
        decoration = field.decoration,
        onSelectionChanged = field.onSelectionChanged,
        onConfirm = field.onConfirm,
        chipDisplay = field.chipDisplay,
        initialValue = field.initialValue,
        otherInitialValue = field.otherInitialValue,
        searchable = field.searchable,
        confirmText = field.confirmText,
        cancelText = field.cancelText,
        barrierColor = field.barrierColor,
        selectedColor = field.selectedColor,
        dialogHeight = field.dialogHeight,
        dialogWidth = field.dialogWidth,
        searchHint = field.searchHint,
        colorator = field.colorator,
        backgroundColor = field.backgroundColor,
        unselectedColor = field.unselectedColor,
        searchIcon = field.searchIcon,
        closeSearchIcon = field.closeSearchIcon,
        itemsTextStyle = field.itemsTextStyle,
        searchHintStyle = field.searchHintStyle,
        searchTextStyle = field.searchTextStyle,
        selectedItemsTextStyle = field.selectedItemsTextStyle,
        separateSelectedItems = field.separateSelectedItems,
        checkColor = field.checkColor,
        isDismissible = field.isDismissible,
        labelText = field.labelText,
        labelStyle = field.labelStyle,
        isLabelPadding = field.isLabelPadding,
        isOptional = field.isOptional,
        optionalWidget = field.optionalWidget,
        isShowOtherValue = field.isShowOtherValue,
        state = state;

  @override
  __MultiSelectDialogFieldViewState createState() =>
      __MultiSelectDialogFieldViewState<V>();
}

class __MultiSelectDialogFieldViewState<V>
    extends State<_MultiSelectDialogFieldView<V>> {
  List<V> _selectedItems = [];
  List<V> _selectedOtherItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems.addAll(widget.initialValue);
    _selectedOtherItems.addAll(widget.otherInitialValue);
  }

  @override
  void didUpdateWidget(_MultiSelectDialogFieldView<V> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      _selectedItems = [];
      _selectedItems.addAll(widget.initialValue);

      // _selectedOtherItems = [];
      // _selectedOtherItems.addAll(widget.initialValue);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.state!.didChange(_selectedItems);
      });
    }
  }

  Widget _buildInheritedChipDisplay() {
    List<MultiSelectItem<V>?> chipDisplayItems = [];
    chipDisplayItems = _selectedItems
        .map((e) =>
            widget.items.firstWhereOrNull((element) => e == element.value))
        .toList();

    if (_selectedOtherItems.isNotEmpty) {
      chipDisplayItems.addAll(_selectedOtherItems
          .map((item) => MultiSelectItem(item, item as String)));
      print("chipDisplayItems after --> ${chipDisplayItems}");
    }

    chipDisplayItems.removeWhere((element) => element == null);
    if (widget.chipDisplay != null) {
      // if user has specified a chipDisplay, use its params
      if (widget.chipDisplay!.disabled!) {
        return Container();
      } else {
        return MultiSelectChipDisplay<V>(
          items: chipDisplayItems,
          colorator: widget.chipDisplay!.colorator ?? widget.colorator,
          onDelete: (item) {
            /*List<V>? newValues;
            if (widget.chipDisplay!.onTap != null) {
              dynamic result = widget.chipDisplay!.onTap!(item);
              if (result is List<V>) newValues = result;
            }
            if (newValues != null) {
              _selectedItems = newValues;
              if (widget.state != null) {
                widget.state!.didChange(_selectedItems);
              }
            }*/
            /// Remove selected Items
            if (item != null) {
              print("_selectedItems---> $_selectedItems");
              _selectedItems.removeWhere((element) => element == item);
              _selectedOtherItems.removeWhere((element) => element == item);

              print("_selectedItems111---> $_selectedItems");
              if (widget.state != null) {
                widget.state!.didChange(_selectedItems);
              }
              if (widget.chipDisplay!.onDelete != null) {
                widget.chipDisplay!.onDelete!(item);
              }
            }
          },
          decoration: widget.chipDisplay!.decoration,
          chipColor: widget.chipDisplay!.chipColor ??
              ((widget.selectedColor != null &&
                      widget.selectedColor != Colors.transparent)
                  ? widget.selectedColor!.withValues(alpha: 0.35)
                  : null),
          alignment: widget.chipDisplay!.alignment,
          textStyle: widget.chipDisplay!.textStyle,
          icon: widget.chipDisplay!.icon,
          shape: widget.chipDisplay!.shape,
          scroll: widget.chipDisplay!.scroll,
          scrollBar: widget.chipDisplay!.scrollBar,
          height: widget.chipDisplay!.height,
          chipWidth: widget.chipDisplay!.chipWidth,
        );
      }
    } else {
      // user didn't specify a chipDisplay, build the default
      return MultiSelectChipDisplay<V>(
        items: chipDisplayItems,
        colorator: widget.colorator,
        chipColor: (widget.selectedColor != null &&
                widget.selectedColor != Colors.transparent)
            ? widget.selectedColor!.withValues(alpha: 0.35)
            : null,
      );
    }
  }

  /// Calls showDialog() and renders a MultiSelectDialog.
  _showDialog(BuildContext ctx) async {
    await showDialog(
      barrierColor: widget.barrierColor,
      barrierDismissible: widget.isDismissible,
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<V>(
          checkColor: widget.checkColor,
          selectedItemsTextStyle: widget.selectedItemsTextStyle,
          searchHintStyle: widget.searchHintStyle,
          searchTextStyle: widget.searchTextStyle,
          itemsTextStyle: widget.itemsTextStyle,
          searchIcon: widget.searchIcon,
          closeSearchIcon: widget.closeSearchIcon,
          unselectedColor: widget.unselectedColor,
          backgroundColor: widget.backgroundColor,
          colorator: widget.colorator,
          searchHint: widget.searchHint,
          selectedColor: widget.selectedColor,
          onSelectionChanged: widget.onSelectionChanged,
          height: widget.dialogHeight,
          width: widget.dialogWidth,
          listType: widget.listType,
          items: widget.items,
          title: widget.title ?? "Select",
          initialValue: _selectedItems,
          otherInitialValue: _selectedOtherItems,
          searchable: widget.searchable ?? false,
          confirmText: widget.confirmText,
          cancelText: widget.cancelText,
          separateSelectedItems: widget.separateSelectedItems,
          isShowOtherValue: widget.isShowOtherValue,
          onConfirm: (selected, others) {
            _selectedItems = selected;
            _selectedOtherItems = others;
            if (widget.state != null) {
              widget.state!.didChange(_selectedItems);
            }
            if (widget.onConfirm != null) {
              widget.onConfirm!(_selectedItems, _selectedOtherItems);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((widget.isLabelPadding == true) ? 18 : 0)),
            child: Row(
              children: [
                BaseText(
                  text: widget.labelText ?? "",
                  fontSize: widget.labelStyle?.fontSize ?? 14,
                  fontWeight: FontWeight.w500,
                  textColor: widget.labelStyle?.color ?? AppColors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getSize(5),
                  ),
                  child: (widget.isOptional == true &&
                          widget.optionalWidget == null)
                      ? BaseText(
                          text: "(Optional)",
                          style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withValues(alpha: 0.8),
                            fontFamily: "Roboto Flex",
                          ),
                        )
                      : widget.optionalWidget ?? Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(8)),
        ],
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            decoration: (widget.state != null && widget.state!.hasError)
                ? BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(getSize(10)),
                    border: Border.all(
                      color: AppColors.red,
                    ),
                  )
                : widget.decoration,
            padding: EdgeInsets.symmetric(
                horizontal: getSize(10), vertical: getSize(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: getSize(7),
                  ),
                  child: widget.buttonText ?? const Text("Select"),
                ),
                widget.buttonIcon ?? const Icon(Icons.arrow_downward),
              ],
            ),
          ),
        ),
        _buildInheritedChipDisplay(),
        widget.state != null && widget.state!.hasError
            ? const SizedBox(height: 5)
            : Container(),
        widget.state != null && widget.state!.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: getSize(18)),
                    child: BaseText(
                      text: widget.state!.errorText!,
                      textColor: AppColors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
