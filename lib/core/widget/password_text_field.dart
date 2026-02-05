import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);
  void toggle() => emit(!state);
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.hint = '********',
    this.onChanged,
    this.helperText,
    this.validator,
    this.label,
    this.isRequired = false,
  });
  final TextEditingController? controller;
  final String hint;
  final Function(String)? onChanged;
  final String? helperText;
  final String? Function(String?)? validator;
  final String? label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: BlocBuilder<PasswordVisibilityCubit, bool>(
        builder: (context, obscure) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null)
                RichText(
                  text: TextSpan(
                    text: label,
                    style: AppTextStyles.s16.w500.textDark,
                    children: isRequired
                        ? const [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
              if (label != null) const SizedBox(height: 6),
              TextFormField(
                controller: controller,
                obscureText: obscure,
                onChanged: onChanged,
                style: AppTextStyles.s16.w600.black,
                validator:
                    validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'يجب ادخال كلمة المرور';
                      }
                      return null;
                    },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  errorStyle: AppTextStyles.s14.w400.redNormal,
                  hintStyle: AppTextStyles.s14.w400.subTextNormal,
                  helperText: helperText,
                  contentPadding: REdgeInsets.symmetric(
                    vertical: 5.r,
                    horizontal: 10.r,
                  ),
                  helperStyle: AppTextStyles.s14.w400.textNormal,
                  prefixIcon: const Icon(
                    CupertinoIcons.lock,
                    color: AppColor.subtextNormal,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.borderColor,
                      width: 1.8.r,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.secondaryNormal,
                      width: 1.8.r,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.subtextLightHover,
                      width: 1.8.r,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.redNormalHover,
                      width: 1.8.r,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        context.read<PasswordVisibilityCubit>().toggle(),
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.subtextNormal,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
