import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  double? width;
  var color;
  var child;
  var text;
  var textcolor;
  var weight;
  var fsize;
  var onTap;
  CustomButton(this.onTap,
      {this.child,
      this.color,
      this.fsize,
      this.text,
      this.textcolor,
      this.weight,
      this.width});

  @override
  Widget build(BuildContext context) {
    double size = Get.width;
    return MaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: width ?? size,
      height: 45,
      elevation: 10,
      color: color ?? const Color(0xFF26AE60),
      child: child ??
          Text(
            text,
            style: TextStyle(
                color: textcolor ?? Colors.white,
                fontWeight: weight ?? FontWeight.normal,
                fontSize: fsize ?? 12.00),
          ),
    );
  }
}
