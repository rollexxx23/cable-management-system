import 'package:admin/utils/extension.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    required this.child,
    required this.onTap,
    this.fill = Colors.white,
    this.border = const Color(0xFFEFEDED),
    Key? key,
  }) : super(key: key);

  const IconBtn.colored({
    required this.child,
    required this.onTap,
    Key? key,
  })  : fill = const Color(0xFFFDFAE2),
        border = const Color(0xFFF16B34),
        super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final Color fill;
  final Color border;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: border,
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(12.scale),
      child: child,
    );
  }
}
