import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/widgets/customTextFormField.dart';
import 'package:to_do_app/widgets/custom_elevated_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void logIn() async {
    if (formKey.currentState!.validate()) {
      final box = await Hive.openBox<UserModel>(AppString.userBox);
      await box.clear();
      await box.add(
        UserModel(
          name: nameController.text,
          image: "",
          motivation: "One task at a time.One step closer",
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (r) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_ToDoApp_appBar.png",
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              "Tasky",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Tasky 👋",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Your productivity journey starts here.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    "assets/images/logo_ToDoApp1.png",
                    height: 205,
                    width: 205,
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your full name";
                      }
                    },
                    title: "Full Name",
                    hintText: "e.g. Khalid",
                    controller: nameController,
                  ),
                  SizedBox(height: 25),
                  CustomElevatedButton(
                    onPressed: logIn,
                    title: "Let’s Get Started",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
