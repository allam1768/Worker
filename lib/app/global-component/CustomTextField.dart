import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isNumber;
  final TextInputType? keyboardType;
  final RxString? errorMessage;
  final String? svgIcon;
  final bool? isPasswordHidden;
  final VoidCallback? onSuffixTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.isNumber = false,
    this.keyboardType,
    this.errorMessage,
    this.svgIcon,
    this.isPasswordHidden,
    this.onSuffixTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = errorMessage == null || errorMessage!.value.isEmpty
        ? const Color(0xFF275637)
        : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.008),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextField(
            controller: controller,
            obscureText: isPassword ? (isPasswordHidden ?? true) : false,
            keyboardType: keyboardType ??
                (isNumber ? TextInputType.number : TextInputType.text),
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.037,
                color: Colors.black),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.037,
                  color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              prefixIcon: svgIcon != null
                  ? Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      child: SvgPicture.asset(
                        svgIcon!,
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.width * 0.06,
                      ),
                    )
                  : null,
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: onSuffixTap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        child: SvgPicture.asset(
                          (isPasswordHidden ?? true)
                              ? 'assets/icons/eye_closed.svg'
                              : 'assets/icons/eye_open.svg',
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.02),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.02),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.02),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
            ),
          ),
        ),
        Obx(() => errorMessage != null && errorMessage!.value.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.height * 0.008),
                child: Text(
                  errorMessage!.value,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}
