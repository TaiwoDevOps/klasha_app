import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    this.labelText,
    this.prefixText,
    this.initialValue,
    this.style,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.showAsterisk = false,
    this.labelStyle,
    this.hintStyle,
    this.isLoading = false,
    this.labelDistance = 4,
    this.suffixText,
    this.decoration,
    this.autoValidateMode,
  }) : super(key: key);
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool enableInteractiveSelection;
  final bool? obscureText;
  final bool enabled;
  final bool isLoading;
  final bool showAsterisk;
  final String? suffixText;
  final InputDecoration? decoration;
  final double labelDistance;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Row(
            children: [
              Text(
                labelText!,
                style: labelStyle ??
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
              ),
              Visibility(
                visible: showAsterisk,
                child: const Text(
                  '*',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: labelDistance),
        ],
        IgnorePointer(
          ignoring: isLoading,
          child: TextFormField(
            controller: controller,
            onSaved: (input) => onSaved?.call((input ?? '').trim()),
            autovalidateMode: autoValidateMode,
            onEditingComplete: onEditingComplete,
            obscureText: obscureText!,
            enableInteractiveSelection: enableInteractiveSelection,
            maxLines: maxLines,
            focusNode: focusNode,
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            keyboardType: inputType,
            textAlign: textAlign,
            enabled: enabled,
            style: style,
            decoration: decoration ??
                InputDecoration(
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  suffixText: suffixText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  prefixText: prefixText,
                  labelStyle: labelStyle,
                  hintStyle:
                      hintStyle ?? const TextStyle(color: Colors.black26),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: maxLines == 1 ? 4.0 : 16.0,
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.4,
                      color: Colors.red,
                    ),
                  ),
                ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}

class ClickableFormField extends StatelessWidget {
  const ClickableFormField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onPressed,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.labelStyle,
  }) : super(key: key);
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final Function()? onPressed;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
        ],
        InkWell(
          onTap: onPressed,
          child: IgnorePointer(
            child: AppTextFormField(
              hintText: hintText,
              hintStyle: labelStyle,
              initialValue: initialValue,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ??
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: Colors.black,
                  ),
              inputType: inputType,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSaved: onSaved,
              validator: validator,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              focusNode: focusNode,
              textAlign: textAlign,
              obscureText: obscureText,
              enableInteractiveSelection: enableInteractiveSelection,
              controller: controller,
              enabled: enabled,
              labelStyle: labelStyle,
            ),
          ),
        ),
      ],
    );
  }
}
