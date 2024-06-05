import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('KDPortal',style: TextStyle(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
