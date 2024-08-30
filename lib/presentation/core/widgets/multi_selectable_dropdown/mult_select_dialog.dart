// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_actions.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_item.dart';
import 'package:shift/presentation/core/widgets/multi_selectable_dropdown/multi_select_list_type.dart';

/// A dialog containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<T> extends StatefulWidget with MultiSelectActions<T> {
  /// List of items to select from.
  final List<MultiSelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;
  final List<T> otherInitialValue;

  /// The text at the top of the dialog.
  final String? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<T>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<T>, List<T>)? onConfirm;

  /// Toggles search functionality. Default is false.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? height;

  /// Sets a fixed width on the dialog.
  final double? width;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(T)? colorator;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  final bool isShowOtherValue;

  MultiSelectDialog({
    required this.items,
    required this.initialValue,
    required this.otherInitialValue,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.searchHint,
    this.height,
    this.width,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchHintStyle,
    this.searchTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isShowOtherValue = true,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<T>(items);
}

class _MultiSelectDialogState<T> extends State<MultiSelectDialog<T>> {
  List<T> _selectedValues = [];
  List<T> _selectedOtherList = [];
  bool _showSearch = false;
  List<MultiSelectItem<T>> _items;

  _MultiSelectDialogState(this._items);

  @override
  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValue);
    _selectedOtherList.addAll(widget.otherInitialValue);

    for (int i = 0; i < _items.length; i++) {
      _items[i].selected = false;
      if (_selectedValues.contains(_items[i].value)) {
        _items[i].selected = true;
      }
    }

    if (widget.separateSelectedItems) {
      _items = widget.separateSelected(_items);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
      ),
      child: CheckboxListTile(
        checkColor: widget.checkColor,
        value: item.selected,
        visualDensity: VisualDensity.compact,
        dense: true,
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : AppColors.primaryColor,
        title: BaseText(
          text: item.label,
          fontSize: 14,
          // style: item.selected
          //     ? widget.selectedItemsTextStyle
          //     : widget.itemsTextStyle,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked!);

            if (checked) {
              item.selected = true;
            } else {
              item.selected = false;
            }
            if (widget.separateSelectedItems) {
              _items = widget.separateSelected(_items);
            }
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<T> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        backgroundColor: widget.unselectedColor,
        selectedColor: widget.colorator?.call(item.value) ??
            widget.selectedColor ??
            Theme.of(context).primaryColor.withOpacity(0.35),
        label: Text(
          item.label,
          style: item.selected
              ? TextStyle(
                  color: widget.selectedItemsTextStyle?.color ??
                      widget.colorator?.call(item.value) ??
                      widget.selectedColor?.withOpacity(1) ??
                      Theme.of(context).primaryColor,
                  fontSize: widget.selectedItemsTextStyle?.fontSize,
                )
              : widget.itemsTextStyle,
        ),
        selected: item.selected,
        onSelected: (checked) {
          if (checked) {
            item.selected = true;
          } else {
            item.selected = false;
          }
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  TextEditingController otherController = TextEditingController();
  // List<MultiSelectItem> otherList = [];

  /*List<T> addOtherValue() {
    String newSkill = otherController.text.trim();
    if (newSkill.isNotEmpty &&
        !otherList.any((item) => item.label == newSkill)) {
      setState(() {
        otherList.add(MultiSelectItem(-1, newSkill, isOther: true));
        otherController.clear();
      });
    }
    _selectedOtherList = [];
    _selectedOtherList.addAll(otherList.map((item) => item.label as T));
    return _selectedOtherList;
  }*/

  List<T> addOtherValue() {
    String newSkill = otherController.text.trim();
    if (newSkill.isNotEmpty &&
        !_selectedOtherList.any((item) {
          item as String;
          return item == newSkill;
        })) {
      _selectedOtherList.addAll([newSkill as T]);
    }
    return _selectedOtherList;
  }

  /*List<T> deleteOtherValue(String value) {
    setState(() {
      otherList.removeWhere((item) => item.label == value);
      otherController.clear();
    });
    _selectedOtherList = [];
    _selectedOtherList.addAll(otherList.map((item) => item.label as T));
    return _selectedOtherList;
  }*/

  List<T> deleteOtherValue(String value) {
    _selectedOtherList.remove(value);

    return _selectedOtherList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor ?? AppColors.scaffoldColor,
      title: widget.searchable == false
          ? BaseText(
              text: widget.title ?? "Select",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _showSearch
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            style: widget.searchTextStyle,
                            decoration: InputDecoration(
                              hintStyle: widget.searchHintStyle,
                              hintText: widget.searchHint ?? "Search",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: widget.selectedColor ??
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              List<MultiSelectItem<T>> filteredList = [];
                              filteredList =
                                  widget.updateSearchQuery(val, widget.items);
                              setState(() {
                                if (widget.separateSelectedItems) {
                                  _items =
                                      widget.separateSelected(filteredList);
                                } else {
                                  _items = filteredList;
                                }
                              });
                            },
                          ),
                        ),
                      )
                    : BaseText(
                        text: widget.title ?? "Select",
                      ),
                IconButton(
                  icon: _showSearch
                      ? widget.closeSearchIcon ?? Icon(Icons.close)
                      : widget.searchIcon ?? Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _showSearch = !_showSearch;
                      if (!_showSearch) {
                        if (widget.separateSelectedItems) {
                          _items = widget.separateSelected(widget.items);
                        } else {
                          _items = widget.items;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
      contentPadding:
          widget.listType == null || widget.listType == MultiSelectListType.LIST
              ? EdgeInsets.only(top: getSize(12))
              : EdgeInsets.all(getSize(20)),
      content: SizedBox(
        height: widget.height ?? getSize(300),
        width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              (widget.listType == null ||
                      widget.listType == MultiSelectListType.LIST)
                  ? ListView.builder(
                      itemCount: _items.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _buildListItem(_items[index]);
                      },
                    )
                  : Wrap(
                      children: _items.map(_buildChipItem).toList(),
                    ),
              if (widget.isShowOtherValue) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(20), vertical: getSize(18)),
                  child: CustomTextField(
                    labelText: "Add Other ${widget.title}",
                    hintText: widget.title,
                    controller: otherController,
                    suffixIcon: CommonButton(
                      height: getSize(27),
                      width: getSize(59),
                      borderRadius: getSize(10),
                      buttonText: StringConstant.add,
                      buttonFontSize: 10,
                      onPressed: () {
                        setState(() {
                          _selectedOtherList = addOtherValue();
                          otherController.clear();
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  child: CustomChipSet(
                    // chipList: otherList.map((item) => item.label).toList(),
                    chipList: _selectedOtherList
                        .map((item) => item as String)
                        .toList(),
                    spacing: 10,
                    onDelete: (value) {
                      setState(() {
                        deleteOtherValue(value);
                        otherController.clear();
                      });
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: EdgeInsets.fromLTRB(
          getSize(20), getSize(10), getSize(20), getSize(20)),
      actions: <Widget>[
        CommonButton(
          width: getSize(140),
          onPressed: () {
            widget.onCancelTap(context, widget.initialValue);
          },
          buttonText: StringConstant.cancle,
          backgroundColor: AppColors.scaffoldColor,
          borderColor: AppColors.primaryColor,
          buttonTextColor: AppColors.primaryColor,
        ),
        CommonButton(
          width: getSize(140),
          onPressed: () {
            // if (selectedOtherList.isNotEmpty) {
            //   _selectedValues
            //       .addAll(selectedOtherList.map((item) => item.label as T));
            // }
            print("Selected Other list ---> $_selectedOtherList");
            widget.onConfirmTap(
                context, _selectedValues, _selectedOtherList, widget.onConfirm);
          },
          buttonText: StringConstant.ok,
        ),
      ],
    );
  }
}
