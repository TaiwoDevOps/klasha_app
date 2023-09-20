import "package:flutter/material.dart";

mixin BaseBottomSheetMixin {
  Widget build(BuildContext context);

  Future<R?> show<R>(
    BuildContext context, {
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<R>(
      isScrollControlled: true,
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => build(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
    );
  }
}
