import 'package:flutter/material.dart';
import 'package:to_do_app/to_do_app.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.iconButton,
    this.withSwitch = false,
  });

  final IconData? icon;
  final String title;
  final VoidCallback? onPressed;
  final Widget? iconButton;
  final bool withSwitch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 25),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          withSwitch
              ? ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeNotifier,
                  builder: (context, mode, _) {
                    return Switch(
                      value: mode == ThemeMode.dark,
                      onChanged: (value) {
                        themeNotifier.value = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                      activeThumbColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade400,
                      splashRadius: 24,
                    );
                  },
                )
              : IconButton(
                  onPressed: onPressed,
                  icon:
                      iconButton ??
                      Icon(
                        Icons.arrow_right_alt_sharp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                ),
        ],
      ),
    );
  }
}
