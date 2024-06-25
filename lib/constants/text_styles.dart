import 'package:flutter/material.dart';

import 'app_color.dart';

class TextStyles {
  static const bodyText = TextStyle(
    fontSize: 14,
    color: AppColors.mainTextColor,
  );

  static const bodyTextMedium =
      TextStyle(color: AppColors.mainTextColor, fontSize: 11);

  static const bodySmall =
      TextStyle(fontSize: 9, color: AppColors.mainTextColor);

  static const bodyTextBold = TextStyle(
    color: AppColors.mainTextColor,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const titleTextSmall =
      TextStyle(color: AppColors.mainTextColor, fontSize: 16);
}
