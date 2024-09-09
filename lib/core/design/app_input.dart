import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? iconData;
  final TextInputType? type;
  final Function(String)? onChanged;
  final double paddingBottom, paddingTop;
  final bool isPassword,isFilled;
  final FormFieldValidator<String?>? validator;
  final Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final TextStyle? textStyle;
  final InputBorder? enableBorder;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const AppInput({
    super.key,
    this.validator,
    this.controller,
    required this.hintText,
    this.paddingBottom = 16,
    this.paddingTop = 0,
    this.isPassword = false,
    this.type,
    this.onChanged,
    this.iconData,
    this.isFilled = false,
    this.fillColor,
    this.enableBorder,
    this.textStyle,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: widget.paddingBottom, top: widget.paddingTop),
      child: TextFormField(
        keyboardType: widget.type,
        textInputAction: widget.textInputAction,
        focusNode: widget.focusNode,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        obscureText: isPasswordHidden && widget.isPassword,
        decoration: InputDecoration(
          fillColor: widget.fillColor,
          enabledBorder: widget.enableBorder,
          filled: widget.isFilled,
          hintText: widget.hintText,
          hintStyle: widget.textStyle,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                      color: Colors.grey,
                  ),
                  onPressed: () {
                    isPasswordHidden = !isPasswordHidden;
                    setState(() {});
                  },
                )
              : widget.suffixIcon,
          prefixIcon: Icon(widget.iconData,color: Colors.grey),
        ),
      ),
    );
  }
}
