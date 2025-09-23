
import 'package:flutter/material.dart';

class Custromappbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double toolbarHeight; 
  const Custromappbar({
    Key? key,
    required this.title,
    this.toolbarHeight = 200.0, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      title: title,
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
     
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight); 
}
