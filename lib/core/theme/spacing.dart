import 'package:flutter/material.dart';

class AppSpacing {
  static const screenPadding =
      EdgeInsets.symmetric(vertical: 20, horizontal: 30);

  static const verticalSpacingBig = 30;
  static const verticalSpacingMedium = 20;
  static const verticalSpacingSmall = 10;

  static final bigVerticalSpacer = SizedBox(
    height: verticalSpacingBig.toDouble(),
  );

  static final mediumVerticalSpacer = SizedBox(
    height: verticalSpacingMedium.toDouble(),
  );

  static final smallVerticalSpacer = SizedBox(
    height: verticalSpacingSmall.toDouble(),
  );
}
