import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({
    super.key,
    this.controller,
    this.keyboard,
    this.hintText,
    this.obstsructText = false,
    this.icon,
    this.validator,
    this.inputFormatters,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.onTap,
    required this.readOnly,
    this.radius = 7,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboard;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final bool obstsructText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffix;
  final BoxConstraints? prefixIconConstraints;
  final bool readOnly;
  final Function()? onTap;
  final double radius;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      obscureText: obstsructText,
      validator: validator,
      onTap: onTap,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.start,
        suffixIcon: suffixIcon,
        suffix: suffix,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 30, 25, 0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'DmSans',
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.w700,
        ),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
      ),
    );
  }
}
