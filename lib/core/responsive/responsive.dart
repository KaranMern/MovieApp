import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double w;
  final double h;

  Responsive(this.context)
    : w = MediaQuery.of(context).size.width,
      h = MediaQuery.of(context).size.height;

  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;

  double get titleSize => isDesktop
      ? w * 0.022
      : isTablet
      ? w * 0.033
      : w * 0.055;

  double get headingSize => isDesktop
      ? w * 0.018
      : isTablet
      ? w * 0.025
      : w * 0.045;

  double get subHeadingSize => isDesktop
      ? w * 0.016
      : isTablet
      ? w * 0.022
      : w * 0.040;

  double get bodySize => isDesktop
      ? w * 0.014
      : isTablet
      ? w * 0.020
      : w * 0.035;

  double get captionSize => isDesktop
      ? w * 0.012
      : isTablet
      ? w * 0.016
      : w * 0.028;

  double get appBarTitleSize => isDesktop
      ? w * 0.018
      : isTablet
      ? w * 0.026
      : w * 0.048;

  double get tabLabelSize => isDesktop
      ? w * 0.014
      : isTablet
      ? w * 0.020
      : w * 0.032;

  double get iconSizeLarge => isDesktop
      ? w * 0.025
      : isTablet
      ? w * 0.035
      : w * 0.065;

  double get iconSizeMedium => isDesktop
      ? w * 0.020
      : isTablet
      ? w * 0.028
      : w * 0.055;

  double get iconSizeSmall => isDesktop
      ? w * 0.015
      : isTablet
      ? w * 0.020
      : w * 0.040;

  double get spacingXS => h * 0.005;
  double get spacingS => h * 0.010;
  double get spacingM => h * 0.020;
  double get spacingL => h * 0.030;
  double get spacingXL => h * 0.040;

  double get paddingS => w * 0.02;
  double get paddingM => w * 0.04;
  double get paddingL => w * 0.06;

  EdgeInsets get screenPadding => EdgeInsets.symmetric(horizontal: paddingM);

  EdgeInsets get cardPadding => EdgeInsets.all(
    isDesktop
        ? w * 0.015
        : isTablet
        ? w * 0.018
        : w * 0.025,
  );

  EdgeInsets get appBarPadding => EdgeInsets.symmetric(vertical: h * 0.015);

  EdgeInsets get tabPadding => EdgeInsets.symmetric(
    horizontal: isDesktop
        ? w * 0.06
        : isTablet
        ? w * 0.15
        : w * 0.13,
  );

  int get gridCrossAxisCount => isDesktop
      ? 4
      : isTablet
      ? 3
      : 2;

  double get gridAspectRatio => isDesktop
      ? 0.65
      : isTablet
      ? 0.70
      : 0.75;

  double get gridSpacing => isDesktop
      ? 16.0
      : isTablet
      ? 12.0
      : 8.0;

  double get gridPadding => w * 0.02;

  double get radiusS => w * 0.02;
  double get radiusM => w * 0.04;
  double get radiusL => w * 0.08;

  BorderRadius get cardRadius => BorderRadius.circular(radiusM);

  BorderRadius get imageHeaderRadius => BorderRadius.only(
    bottomLeft: Radius.circular(radiusL),
    bottomRight: Radius.circular(radiusL),
  );

  double get detailImageHeight => isMobile ? h * 0.45 : h;

  TextStyle titleStyle(Color color, {FontWeight weight = FontWeight.bold}) =>
      TextStyle(fontSize: titleSize, fontWeight: weight, color: color);

  TextStyle headingStyle(Color color, {FontWeight weight = FontWeight.bold}) =>
      TextStyle(fontSize: headingSize, fontWeight: weight, color: color);

  TextStyle subHeadingStyle(
    Color color, {
    FontWeight weight = FontWeight.w600,
  }) => TextStyle(fontSize: subHeadingSize, fontWeight: weight, color: color);

  TextStyle bodyStyle(Color color, {FontWeight weight = FontWeight.normal}) =>
      TextStyle(fontSize: bodySize, fontWeight: weight, color: color);

  TextStyle captionStyle(Color color, {FontWeight weight = FontWeight.w400}) =>
      TextStyle(fontSize: captionSize, fontWeight: weight, color: color);

  TextStyle appBarTitleStyle(Color color) => TextStyle(
    fontSize: appBarTitleSize,
    fontWeight: FontWeight.bold,
    color: color,
  );

  TextStyle tabLabelStyle(Color color, {FontWeight weight = FontWeight.w600}) =>
      TextStyle(fontSize: tabLabelSize, fontWeight: weight, color: color);
}
