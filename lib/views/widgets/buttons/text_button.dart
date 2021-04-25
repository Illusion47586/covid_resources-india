import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/models/data_model.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
  }) {
    backgroundColor = Colors.black;
    foregroundColor = Colors.white;
    overlayColor = Colors.grey.shade900;
    shadowColor = Colors.black.withOpacity(0.16);
    if (icon != null) hasIcon = true;
  }

  CustomTextButton.red({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
  }) {
    backgroundColor = AppColors.accentRed;
    foregroundColor = Colors.white;
    overlayColor = AppColors.dark.withOpacity(0.03);
    shadowColor = AppColors.accentRedDark.withOpacity(0.1);
    if (icon != null) hasIcon = true;
  }

  CustomTextButton.purple({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
  }) {
    backgroundColor = AppColors.accentPurple;
    foregroundColor = AppColors.light;
    overlayColor = AppColors.dark.withOpacity(0.03);
    shadowColor = AppColors.accentPurpleDark.withOpacity(0.16);
    if (icon != null) hasIcon = true;
  }

  CustomTextButton.blue({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
  }) {
    backgroundColor = AppColors.accentBlue;
    foregroundColor = AppColors.light;
    overlayColor = AppColors.dark.withOpacity(0.03);
    shadowColor = AppColors.accentBlueDark.withOpacity(0.16);
    if (icon != null) hasIcon = true;
  }

  CustomTextButton.green({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
  }) {
    backgroundColor = AppColors.accentGreenDark;
    foregroundColor = AppColors.light;
    overlayColor = AppColors.dark.withOpacity(0.03);
    shadowColor = AppColors.accentGreenDark.withOpacity(0.16);
    if (icon != null) hasIcon = true;
  }

  CustomTextButton.issue({
    this.icon,
    this.text,
    this.function,
    this.longTapFunction,
    this.elevation = 30,
    @required this.issue,
  }) {
    switch (issue) {
      case Issue.vaccine:
        backgroundColor = AppColors.accentBlue;
        foregroundColor = AppColors.light;
        overlayColor = AppColors.dark.withOpacity(0.03);
        shadowColor = AppColors.accentBlueDark.withOpacity(0.16);
        break;
      case Issue.oxygen:
        backgroundColor = AppColors.accentRed;
        foregroundColor = Colors.white;
        overlayColor = AppColors.dark.withOpacity(0.03);
        shadowColor = AppColors.accentRedDark.withOpacity(0.1);
        break;
      case Issue.hospital:
        backgroundColor = AppColors.accentGreenDark;
        foregroundColor = AppColors.light;
        overlayColor = AppColors.dark.withOpacity(0.03);
        shadowColor = AppColors.accentGreenDark.withOpacity(0.16);
        break;
      case Issue.plasma:
        backgroundColor = AppColors.accentPurple;
        foregroundColor = AppColors.light;
        overlayColor = AppColors.dark.withOpacity(0.03);
        shadowColor = AppColors.accentPurpleDark.withOpacity(0.16);
        break;
      default:
        backgroundColor = Colors.black;
        foregroundColor = Colors.white;
        overlayColor = Colors.grey.shade900;
        shadowColor = Colors.black.withOpacity(0.16);
    }
    if (icon != null) hasIcon = true;
  }

  final IconData icon;
  final String text;
  final Function function;
  final Function longTapFunction;
  final double elevation;
  bool disabled;
  Color backgroundColor;
  Color foregroundColor;
  Color overlayColor;
  Color shadowColor;
  bool hasIcon = false;
  Issue issue;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      onLongPress: longTapFunction,
      style: Theme.of(context).textButtonTheme.style.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              foregroundColor,
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              overlayColor,
            ),
            shadowColor: MaterialStateProperty.all<Color>(
              shadowColor,
            ),
            elevation: MaterialStateProperty.all(elevation),
          ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          maxWidth: double.infinity,
        ),
        child: Builder(
          builder: (context) {
            if (hasIcon)
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    text,
                    style: kTextTitle2Style.copyWith(
                      color: foregroundColor,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                  ),
                  const Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 15,
                    ),
                  ),
                  Icon(
                    icon,
                    size: 28,
                    color: foregroundColor,
                  ),
                ],
              );
            else
              return Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    text,
                    style: kTextTitle2Style.copyWith(
                      color: foregroundColor,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}
