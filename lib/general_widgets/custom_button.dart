import 'package:flutter/material.dart';
import 'package:swift_chat/utils/app_extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  final Color? color;
  final String? text;
  final Color? textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Center(
          child: Text(
            text!,
            style: context.$style.bodyLarge!.copyWith(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
