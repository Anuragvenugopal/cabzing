import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildElevatedButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final double borderRadius;
  final double? height;
  final double? width;
  final IconData? suffixIcon;
  final String? svgSuffixIcon;
  final String? svgPrefixIcon;

  const BuildElevatedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.elevation = 2.0,
    this.borderRadius = 8.0,
    this.height,
    this.width,
    this.suffixIcon,
    this.svgSuffixIcon,
    this.svgPrefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgPrefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  svgPrefixIcon!,
                  width: 20.0,
                  height: 20.0,
                  color: textColor,
                ),
              ),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 16.0,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (svgSuffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  svgSuffixIcon!,
                  width: 20.0,
                  height: 20.0,
                  color: textColor,
                ),
              ),
            if (suffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  suffixIcon,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
