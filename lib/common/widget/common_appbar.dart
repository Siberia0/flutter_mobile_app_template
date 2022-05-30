import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double titleFontSize;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  const CommonAppBar({
    Key? key,
    required this.title,
    this.titleFontSize = 20.0,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          (ModalRoute.of(context)?.canPop ?? false) ? const BackButton() : null,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          color: AppColor.base,
          fontSize: titleFontSize,
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: AppColor.primary,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
