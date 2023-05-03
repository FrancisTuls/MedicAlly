import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.isDarkMode,
    required this.icon,
    required this.title,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final bool isDarkMode;
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: isDarkMode
                ? darkColorScheme.secondary.withOpacity(0.3)
                : lightColorScheme.secondary.withOpacity(0.3)),
        child: Icon(
          icon,
          color:
              isDarkMode ? darkColorScheme.primary : lightColorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.3)),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black,
              ),
            )
          : null,
    );
  }
}
