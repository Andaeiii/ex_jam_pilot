import 'package:flutter/material.dart';

class FormBtns {
  /// Fancy Elevated Button
  static Widget elevated({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.blue,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  /// Fancy Outlined Button
  static Widget outlined({
    required String text,
    required VoidCallback onPressed,
    Color borderColor = Colors.blue,
    Color textColor = Colors.blue,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  /// Fancy Text Button
  static Widget text({
    required String text,
    required VoidCallback onPressed,
    Color textColor = Colors.blue,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }

  /// Fancy Icon Button
  static Widget icon({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.blue,
    double size = 28,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size, color: color),
      splashRadius: 24,
    );
  }

  /// Fancy Filled Button
  static Widget filled({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.green,
    Color textColor = Colors.white,
  }) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  /// Fancy Filled Tonal Button
  static Widget filledTonal({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.purple,
    Color textColor = Colors.white,
  }) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color.withOpacity(0.7),
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  /// Fancy Floating Action Button
  static Widget fab({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.red,
    Color iconColor = Colors.white,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Icon(icon, color: iconColor),
    );
  }

  /// Fancy Gradient Button (custom container)
  static Widget gradient({
    required String text,
    required VoidCallback onPressed,
    List<Color> colors = const [Colors.blue, Colors.purple],
    Color textColor = Colors.white,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
        ),
      ),
    );
  }
}
