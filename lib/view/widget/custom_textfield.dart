import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final Function()? onTap;
  final String? initialValue;
  final bool readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final VoidCallback? onEditComplete;
  final int maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final EdgeInsets? contentPadding;
  final bool isErrorState;

  const CustomTextField({
    super.key,
    required this.name,
    this.hintText,
    this.onEditComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.textInputAction = TextInputAction.done,
    this.onTap,
    this.fillColor = AppColors.white,
    this.borderColor = AppColors.primary,
    this.readOnly = false,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.isErrorState = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FormBuilderTextField(
        textInputAction: textInputAction,
        validator: validator,
        controller: controller,
        onEditingComplete: onEditComplete,
        onChanged: onChanged,
        onTap: onTap,
        name: name,
        readOnly: readOnly,
        initialValue: initialValue,
        style: Theme.of(context).textTheme.bodyMedium,
        cursorColor: AppColors.black,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                letterSpacing: 1,
                color: AppColors.black.withOpacity(0.5),
              ),
          fillColor: fillColor,
          filled: true,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              color: isErrorState
                  ? AppColors.red
                  : borderColor ?? AppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(
              color: isErrorState
                  ? AppColors.red
                  : borderColor ?? AppColors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: AppColors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: const BorderSide(
              color: AppColors.red,
            ),
          ),
        ),
      ),
    );
  }
}
