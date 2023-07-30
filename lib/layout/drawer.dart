import 'package:flutter/material.dart';
import 'package:to_do/shared/components/drawer_items.dart';
class Draweer extends StatelessWidget {
  const Draweer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:   [
        DrawerHeader(

          curve: Curves.decelerate,
          decoration: BoxDecoration(
            // color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(0.5)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Padding(
                padding: EdgeInsets.only(left: 11),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(
                    'assets/profile0.jpg',
                  ),
                  backgroundColor: Colors.indigo,
                ),
              ),
              ListTile(
                title: Text("Mazen Glal",style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                subtitle: Text("mazenglal@gmail.com",style: TextStyle(color: Colors.white.withOpacity(0.8)),),
              )
            ],
          ),
        ),
        const DrawerItem(iconData: Icons.card_giftcard, title: "Payment"),
        const DrawerItem(iconData: Icons.panorama, title: "Promos"),
        const DrawerItem(iconData: Icons.notifications_active, title: "Notifications"),
        const DrawerItem(iconData: Icons.help, title: "Help"),
        const DrawerItem(iconData: Icons.call_outlined, title: "About Us"),
        const DrawerItem(iconData: Icons.star, title: "Rate Us"),

        // MaterialButton(
        //   color: Colors.lightGreen,
        //   height: 28,
        //   // minWidth: 1000,
        //   // padding: EdgeInsets.symmetric(horizontal: 10),
        //   onPressed: () {},
        //   child: const Text("Logout"),
        // ),
      ],
    );
  }
}
