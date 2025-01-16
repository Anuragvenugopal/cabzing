import 'package:flutter/material.dart';
import 'package:cabzing/widgets/build_text_widget.dart';
import 'package:cabzing/widgets/icon_button_widget.dart';

class BuildDropDownButtonFormWidget extends StatelessWidget {
  final String selectedValue;
  final List<String> items;
  final Function(String?) onChanged;
  final String hintText;
  final Color dropdownColor;
  final Color fillColor;
  final Color textColor;
  final IconData? icon;
  final double? height;
  final double? width;
  final double borderRadius;

  BuildDropDownButtonFormWidget({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.dropdownColor = Colors.grey,
    this.fillColor = Colors.grey,
    this.textColor = Colors.white,
    this.icon,
    this.height,
    this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        dropdownColor: dropdownColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
        ),
        items: items
            .map(
              (option) => DropdownMenuItem<String>(
            value: option,
            child: BuildTextWidget(
              text: option,
              color: textColor,
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
        isExpanded: true,
        icon: icon != null
            ? IconButtonWidget(
          icon: Icon(icon, color: textColor),
          onTap: () {},
        )
            : Icon(Icons.keyboard_arrow_down, color: textColor),
      ),
    );
  }
}
