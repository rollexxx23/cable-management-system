import 'package:flutter/material.dart';

extension Responsive on num {
  double get scale => this * 0.7;
  double get bigScale => this * 0.8;
  double getResponsiveWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 1920);

  double getResponsiveHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 1200);
}

double getWidthResizeFactor(double width) {
  if (width > 1366) {
    return 1;
  } else if (width > 1280) {
    return 1.2;
  } else if (width > 1080) {
    return 1.3;
  } else if (width > 868) {
    return 1.5;
  } else if (width > 720) {
    return 1.8;
  } else if (width > 600) {
    return 2.2;
  } else if (width > 480) {
    return 2.5;
  } else {
    return 2.8;
  }
}
