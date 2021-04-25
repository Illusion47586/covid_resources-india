import '../../../core/models/data_model.dart';
import '../../../core/theme/colors.dart';
import 'package:flutter/material.dart';

const double iconSize = 35;

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
  }) {
    foregroundColor = AppColors.dark;
  }

  CustomIconButton.blue({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
  }) {
    foregroundColor = AppColors.accentBlue;
  }

  CustomIconButton.red({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
  }) {
    foregroundColor = AppColors.accentRed;
  }

  CustomIconButton.purple({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
  }) {
    foregroundColor = AppColors.accentPurple;
  }

  CustomIconButton.green({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
  }) {
    foregroundColor = AppColors.accentGreenDark;
  }

  CustomIconButton.issue({
    this.icon = Icons.question_answer,
    this.label = '',
    this.function,
    @required this.issue,
  }) {
    switch (issue) {
      case Issue.vaccine:
        foregroundColor = AppColors.accentBlue;
        break;
      case Issue.oxygen:
        foregroundColor = AppColors.accentRed;
        break;
      case Issue.hospital:
        foregroundColor = AppColors.accentGreenDark;
        break;
      case Issue.plasma:
        foregroundColor = AppColors.accentPurple;
        break;
      default:
        foregroundColor = AppColors.dark;
    }
  }

  final IconData icon;
  final String label;
  final Function function;
  Issue issue;
  Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: foregroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(
            icon,
            semanticLabel: label ?? 'null',
          ),
          iconSize: iconSize,
          padding: const EdgeInsets.all(12),
          color: foregroundColor,
          onPressed: function,
        ),
      ),
    );
  }
}
