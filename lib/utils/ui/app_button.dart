import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.textTitle,
    required this.action,
    this.deActivate,
    Key? key,
    this.fullWidth = true,
    this.showLoading,
    this.color,
    this.backgroundColor,
    this.loadingColor,
    this.decoration,
    this.child,
  }) : super(key: key);
  final String textTitle;
  final bool fullWidth;
  final bool? showLoading;
  final bool? deActivate;
  final Decoration? decoration;
  final Color? color, backgroundColor, loadingColor;
  final VoidCallback action;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: 54,
      width: fullWidth ? double.maxFinite : null,
      child: ElevatedButton(
        key: key,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor:
                  MaterialStateProperty.all<Color>(backgroundColor!),
            ),
        onPressed: showLoading == true || deActivate == true ? null : action,
        child: showLoading == true
            ? Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color ?? Theme.of(context).primaryColor,
                  ),
                ),
              )
            : child ??
                Text(
                  textTitle,
                  style: TextStyle(
                    color: deActivate == true
                        ? Colors.grey.shade400
                        : color ?? Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }
}
