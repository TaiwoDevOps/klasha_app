import "package:flutter/material.dart";
import "package:klasha_app/utils/ui/base_bottom_sheet.dart";
import "package:klasha_app/utils/ui/bottom_sheet_mixin.dart";

class FutureBottomSheet<T> extends StatelessWidget with BaseBottomSheetMixin {
  const FutureBottomSheet(
      {required this.future,
      required this.itemBuilder,
      required this.title,
      this.subtitle,
      this.onItemSelected,
      Key? key})
      : super(key: key);

  final String title;
  final String? subtitle;

  final Future<List<T>> Function() future;
  final Function(T)? onItemSelected;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    var child = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<T>>(
            future: future(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    physics: const PageScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          if (onItemSelected != null) {
                            onItemSelected!(item);
                          } else {
                            Navigator.of(context).pop(item);
                          }
                        },
                        child: itemBuilder(context, item),
                      );
                    });
              }
              if (snapshot.hasError) {
                return const SizedBox.shrink();
              }
              return const CircularProgressIndicator.adaptive();
            }),
      ],
    );

    return BaseBottomSheet(title: title, subtitle: subtitle, child: child);
  }
}
