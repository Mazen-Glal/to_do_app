import 'package:flutter/material.dart';
class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.iconData, required this.title});
  final IconData iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading:  Icon(iconData,color: Colors.white.withOpacity(0.8)),
      title:  Text(title,style:  TextStyle(color: Colors.white.withOpacity(0.8)),),
      onTap: () {

      },
    );
  }
}
