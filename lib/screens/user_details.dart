import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/widgets/customTextFormField.dart';
import 'package:to_do_app/widgets/custom_elevated_button.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetails> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController motivationQuoteController = TextEditingController();
  UserModel? user = Hive.box<UserModel>(AppString.userBox).getAt(0);
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "User Details",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                CustomTextFormField(
                  title: "User Name",
                  hintText: user!.name,
                  maxLines: 1,
                  controller: userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new user name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  title: "Motivation Quote",
                  hintText: user!.motivation,
                  maxLines: 5,
                  controller: motivationQuoteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new motivation quote";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        user!.name = userNameController.text;
                        user!.motivation = motivationQuoteController.text;
                        await user!.save();
                        setState(() {
                          Navigator.pop(context);
                        });
                      }
                    },
                    title: "Save Changes",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
