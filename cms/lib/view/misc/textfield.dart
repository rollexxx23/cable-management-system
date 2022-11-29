import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';

Widget customTextField({
  String? hintText,
  GlobalKey<FormFieldState>? key,
  required TextEditingController controller,
  FocusNode? focusNode,
  String? Function(String?)? validator,
  int? maxLength,
  int? maxLines = 1,
  double? height,
  bool isError = false,
  bool? isObscure,
  bool showblindIcon = false,
  bool isPhone = false,
  bool hasFocus = false,
  bool readOnly = false,
  bool isDecimal = false,
  String? errorText,
  Widget? suffixIcon,
  InputBorder? border,
  TextInputType? keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  EdgeInsets? contentPadding,
  List<TextInputFormatter>? inputFormatters,
  void Function()? onTap,
  void Function(String?)? onChanged,
  void Function(String?)? onSubmitted,
  void Function()? onEditingComplete,
  void Function()? onEyeButtonPressed,
}) {
  return SizedBox(
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: isPhone == false
                ? const BorderRadius.all(
                    Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            border: Border.fromBorderSide(
              BorderSide(
                  color: isError == true
                      ? AppColors.red
                      : hasFocus == true
                          ? AppColors.black
                          : AppColors.grey,
                  width: (1)),
            ),
          ),
          child: SizedBox(
            height: height,
            child: TextFormField(
              key: key,
              readOnly: readOnly,
              validator: validator,
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              maxLength: maxLength,
              maxLines: maxLines,
              obscureText: isObscure ?? false,
              inputFormatters: inputFormatters,
              style: TextStyle(
                fontSize: (18),
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                counterText: '',
                contentPadding: contentPadding ??
                    EdgeInsets.fromLTRB(
                      (20),
                      (8),
                      (20),
                      hasFocus ? (22) : (24),
                    ),
                suffixIcon: showblindIcon == true
                    ? IconButton(
                        icon: Icon(
                          Icons.password,
                          color: isObscure == false
                              ? AppColors.primaryColor
                              : Colors.grey[350],
                        ),
                        onPressed: onEyeButtonPressed,
                      )
                    : Padding(
                        padding: EdgeInsets.only(right: (10)),
                        child: suffixIcon,
                      ),
                labelText: hintText,
                alignLabelWithHint: true,
                errorText: null,
                errorStyle: const TextStyle(
                  fontSize: 0,
                  height: 0,
                  color: Colors.transparent,
                ),
              ),
              onTap: onTap,
              onChanged: onChanged,
              onFieldSubmitted: onSubmitted,
              onEditingComplete: onEditingComplete,
            ),
          ),
        ),
        Visibility(
          visible: isError == true && errorText != null,
          child: Positioned(
            bottom: (10),
            left: (20),
            child: Text(
              errorText!,
            ),
          ),
        ),
      ],
    ),
  );
}
