import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/to_do_app.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    final user = Hive.box<UserModel>(AppString.userBox).getAt(0);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: CircleAvatar(
          radius: 1000,
          backgroundImage: (user != null && user.image.isNotEmpty)
              ? FileImage(File(user.image))
              : AssetImage("assets/images/image_home_appbar.png"),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Welcome ,${user!.name}",
            style: TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            user.motivation,
            style: TextStyle(
              fontSize: 15,

              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
              icon: themeNotifier.value == ThemeMode.light
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.light_mode),
              onPressed: () {
                themeNotifier.value == ThemeMode.light
                    ? themeNotifier.value = ThemeMode.dark
                    : themeNotifier.value = ThemeMode.light;
              },
              color: themeNotifier.value == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
