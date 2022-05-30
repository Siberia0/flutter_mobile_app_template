import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/app_color.dart';

class CommonTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final int maxLength;
  final int? maxLines;
  final TextEditingController controller;
  final String? labelText;
  final GestureTapCallback? onTap;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool addRedEyeIcon;
  final Widget? additionalWidget;
  final EdgeInsets padding;
  final double labelFontSize;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final VoidCallback? onKillFocus;
  const CommonTextFormField(
    this.keyboardType,
    this.maxLength,
    this.controller,
    this.labelText, {
    super.key,
    this.onTap,
    this.onKillFocus,
    this.hintText,
    this.inputFormatters,
    this.additionalWidget,
    this.floatingLabelBehavior,
    this.maxLines = 1,
    this.readOnly = false,
    this.addRedEyeIcon = false,
    this.padding = const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
    this.labelFontSize = 18.0,
  });

  @override
  State<StatefulWidget> createState() => CommonTextFormFieldState();
}

class CommonTextFormFieldState extends State<CommonTextFormField> {
  FocusNode? _focusNode;
  bool _obscureText = false;

  // Determines if the setting is to enable obscurity
  bool _isObscureNode() => widget.addRedEyeIcon;

  @override
  void initState() {
    super.initState();

    _obscureText = _isObscureNode();

    if (widget.onKillFocus != null) {
      _focusNode = FocusNode();
      _focusNode?.addListener(() {
        if (_focusNode?.hasFocus == false ||
            _focusNode?.hasPrimaryFocus == false) {
          widget.onKillFocus!();
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        children: [
          Expanded(
            child: Form(
              child: TextFormField(
                obscureText: _obscureText,
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                focusNode: _focusNode,
                inputFormatters: widget.inputFormatters,
                maxLength: widget.maxLength,
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                autofocus: false,
                controller: widget.controller,
                autovalidateMode: AutovalidateMode.always,
                validator: null,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: AppColor.grayScale,
                  ),
                  labelText: widget.labelText,
                  labelStyle: TextStyle(
                    fontSize: widget.labelFontSize,
                    height: 0.8,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grayScale,
                  ),
                  errorStyle: const TextStyle(
                    color: AppColor.alert,
                  ),
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  suffixIcon: _buildSuffixWidget(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildSuffixWidget() {
    if (widget.addRedEyeIcon) {
      return IconButton(
        icon: Icon(_obscureText
            ? Icons.remove_red_eye
            : Icons.remove_red_eye_outlined),
        onPressed: () async {
          // Keyboard status will not be updated without this sequence of processing.
          final bool hasFocus = _focusNode?.hasPrimaryFocus ?? false;
          if (hasFocus) {
            FocusScope.of(context).unfocus();
          }
          _obscureText = !_obscureText;
          await Future.delayed(const Duration(milliseconds: 100));

          setState(() {
            if (hasFocus) {
              FocusScope.of(context).requestFocus(_focusNode);
            }
          });
        },
      );
    } else if (widget.additionalWidget != null) {
      return widget.additionalWidget;
    } else {
      return null;
    }
  }
}
