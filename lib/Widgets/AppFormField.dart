import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/Validator.dart';


class AppFormField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? initialValue;
  final String? helperText;

  final int? maxLines;
  final int? maxLength;
  final int? minLength;

  final double? labelSize;
  final double? hintSize;
  final double? fontSize;

  final double borderRadius;
  final double marginBottom;

  final bool outsideLabel;
  final bool filled;
  final bool required;
  final bool isPasswordField;
  final bool isNumberOnly;
  final bool readOnly;

  final TextInputType keyboardType;
  final TextEditingController? controller;

  final Icon? prefixIcon;

  final Function? validator;
  final IconData? suffixIcon;
  final Function? onFocus;
  final Function? onTapSuffix;
  final double padding;
  final TextInputAction? textInputAction;

  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;

  const AppFormField({
    Key? key,
    this.onTapSuffix,
    this.marginBottom = 0,
    this.onFocus,
    this.suffixIcon,
    this.borderRadius = 5,
    this.validator,
    this.required = false,
    this.initialValue,
    this.label,
    this.placeholder,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    this.outsideLabel = true,
    this.filled = false,
    this.helperText,
    this.labelColor,
    this.padding = 10,
    this.maxLength,
    this.textInputAction,
    this.minLength,
    this.isNumberOnly = false,
    this.readOnly = false,
    this.fillColor,
    this.labelSize,
    this.hintSize,
    this.fontSize,
    this.hintColor,
  }) : super(key: key);

  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool passwordVisible = false;
  FocusNode? focusNode;
  bool isEnable = true;

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();

    focusNode = FocusNode();
    focusNode!.addListener(() {
      if (widget.onFocus != null) {
        widget.onFocus!();
      }
    });

    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        focusNode!.unfocus();
      }
    });
  }

  @override
  void dispose() {
    focusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? _suffixIcon;
    if (widget.isPasswordField) {
      _suffixIcon = IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      );
    } else {
      if (widget.suffixIcon != null) {
        _suffixIcon = IconButton(
          icon: Icon(widget.suffixIcon),
          onPressed: () {
            if (widget.onTapSuffix != null) {
              widget.onTapSuffix!();
            }
          },
        );
      }
    }

    // _suffixIcon ??= Container(
    //   width: 1,
    // );

    bool showOutsideLabel = widget.outsideLabel && widget.label != null;

    return Container(
        margin: EdgeInsets.only(
          bottom: widget.marginBottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: showOutsideLabel,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: '',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: GoogleFonts.sarabun().fontFamily,
                    color: widget.labelColor ?? Colors.grey,
                    fontSize: widget.labelSize,
                  ),
                  children: <TextSpan>[
                    if (widget.required)
                      const TextSpan(
                        text: '* ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    TextSpan(
                      text: widget.label ?? '',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: showOutsideLabel ? 5 : 0),
            TextFormField(
              focusNode: focusNode,
              initialValue: widget.initialValue,
              maxLines: widget.maxLines ?? 1,
              controller: widget.controller,
              obscureText: !widget.isPasswordField ? false : !passwordVisible,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              style: TextStyle(fontSize: widget.fontSize),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontSize: widget.labelSize ?? 13,
                ),
                hintStyle: TextStyle(
                  fontSize: widget.hintSize ?? 13,
                  color: widget.hintColor ?? Colors.grey,
                ),
                errorStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                ),
                filled: widget.filled,
                contentPadding: EdgeInsets.all(widget.padding),
                isDense: true,
                hintText: widget.placeholder,
                labelText: !showOutsideLabel ? widget.label : null,
                suffixIcon: _suffixIcon,
                prefixIcon: widget.prefixIcon,
                fillColor: widget.fillColor ?? Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: HexColor('#CCCCCC'), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: widget.labelColor ?? Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: HexColor('#CCCCCC'), width: .5),
                ),
              ),
              keyboardType: widget.keyboardType,
              validator: (value) {
                var validator = Validator();
                validator.value = value;

                if (widget.required == true && validator.isBlank) {
                  return 'กรุณากรอก ${widget.label ?? widget.placeholder ?? 'ข้อมูล'}';
                }

                if (widget.minLength != null &&
                    (value?.length ?? 0) < widget.minLength!) {
                  return 'ความยาวไม่ต่ำกว่า ${widget.minLength} ตัวอักษร';
                }

                if (widget.isNumberOnly && !validator.isNumber()) {
                  return 'กรุณากรอกข้อมูลให้ถูกต้อง';
                }

                if (widget.validator != null) {
                  return widget.validator!(value);
                }

                return null;
              },
              readOnly: widget.readOnly,
            ),
            Visibility(
              visible: widget.helperText != null,
              child: Text(
                widget.helperText ?? '',
                style: TextStyle(
                  color: HexColor('#FF9A9A'),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ));
  }
}
