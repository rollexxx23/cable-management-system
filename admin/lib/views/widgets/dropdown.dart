import 'package:admin/utils/extension.dart';
import 'package:flutter/material.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({
    Key? key,
    required this.options,
    required this.width,
    this.style,
    this.fillColor,
  }) : super(key: key);

  final List<String> options;
  final TextStyle? style;
  final Color? fillColor;
  final double width;
  const DropdownBtn.colored({
    Key? key,
    required this.options,
    required this.width,
  })  : style = const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFF16B34)),
        fillColor = Colors.white,
        super(key: key);

  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  late String value = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: DropdownButton<String>(
        items: widget.options
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    e,
                    style: widget.style ??
                        TextStyle(
                          fontSize: 16.bigScale,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          setState(() {
            value = val!;
          });
        },
        isDense: true,
        dropdownColor: widget.fillColor ?? const Color(0xFFF0F0F0),
        value: value,
        isExpanded: true,
        borderRadius: BorderRadius.circular(5),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: widget.style?.color ?? Colors.black,
        ),
        underline: const SizedBox(),
      ),
    );
  }
}
