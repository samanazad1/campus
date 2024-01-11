import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: DrawerHeader(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.018,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor.withAlpha(50),
                        radius: 25,
                        child: const Icon(
                          IconlyBold.profile,
                          color: primaryColor,
                          size: 45,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Guest'),
                          Text(
                            'ID: 0000',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.014,
          ),
          DrawerItem(
            size: size,
            title: "College Informations",
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          DrawerItem(size: size, title: "College Dean Members"),
          SizedBox(
            height: size.height * 0.01,
          ),
          DrawerItem(size: size, title: "Contact Us"),
          SizedBox(
            height: size.height * 0.01,
          ),
          Divider(
            endIndent: 20,
            color: primaryColor.withAlpha(99),
            indent: 20,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          DrawerItem(size: size, title: "Feedback"),
          SizedBox(
            height: size.height * 0.01,
          ),
          DrawerItem(size: size, title: "Developer Info")
        ],
      ),
    );
  }
}


class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: size.height * 0.065,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor.withAlpha(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 78, 78, 78),
          )
        ],
      ),
    );
  }
}
