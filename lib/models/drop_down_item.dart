import 'package:flutter/material.dart';

class DropDownItem {
  final String text;
  final IconData iconData;
  // final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  DropDownItem(
      {this.text,
      this.iconData,
      // this.isSelected = false,
      this.isFirstItem = false,
      this.isLastItem = false});

  factory DropDownItem.first(
      {String text, IconData iconData}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      // isSelected: isSelected,
      isFirstItem: true,
    );
  }

  factory DropDownItem.last(
      {String text, IconData iconData}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      // isSelected: isSelected,
      isLastItem: true,
    );
  }
}
