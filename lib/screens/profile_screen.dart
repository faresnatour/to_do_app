import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/screens/Log_in_screen.dart';
import 'package:to_do_app/screens/completed_screen.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/todo_screen.dart';
import 'package:to_do_app/screens/user_details.dart';
import 'package:to_do_app/widgets/bottom_nav_bar.dart';
import 'package:to_do_app/widgets/profile_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    loaduser();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    XFile? photo;
    void openCamera() async {
      photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        user!.image = photo!.path;
        await user!.save();
      }
    }

    void openGallery() async {
      photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        user!.image = photo!.path;
        await user!.save();
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Center(
                  child: Text(
                    "My Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20),

                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            (user != null && user!.image.isNotEmpty)
                            ? FileImage(File(user!.image))
                            : AssetImage("assets/images/image_home_appbar.png"),
                      ),
                      InkWell(
                        child: Icon(Icons.camera_alt_outlined),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xff14A662),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: InkWell(
                                      onTap: () => openCamera(),
                                      child: Text(
                                        "Upload from camera",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xff14A662),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: InkWell(
                                      onTap: () => openGallery(),
                                      child: Text(
                                        "Upload from gallery",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Lottie.asset(
                                    "assets/images/showModalBottomSheet.json",
                                    height: 260,
                                    width: double.infinity,
                                    repeat: false,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    user!.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: Text(
                    user!.motivation,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Profile Info",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                ProfileInfo(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetails()),
                    );
                    setState(() {});
                  },
                  icon: Icons.person_outline_rounded,
                  title: "User Details",
                  iconButton: Icon(
                    Icons.arrow_right_alt_sharp,
                    size: 30,

                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 1, height: 0.5),
                ProfileInfo(
                  icon: Icons.person_outline_rounded,
                  title: "Dark Mode",
                  withSwitch: true,
                ),
                Divider(thickness: 1, height: 0),
                ProfileInfo(
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false,
                    );
                    setState(() {});
                  },
                  icon: Icons.logout_outlined,
                  title: "Log Out",
                  iconButton: Icon(
                    Icons.arrow_right_alt_sharp,
                    size: 30,
                    color: Colors.red,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TodoScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CompletedScreen()),
            );
          } else if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
      ),
    );
  }

  void loaduser() {
    user = Hive.box<UserModel>(AppString.userBox).getAt(0);
  }
}
