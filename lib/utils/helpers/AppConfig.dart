// File: /d:/flutterPROJs/exjam_prj/lib/utils/helpers/AppConfig.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../apis/config.dart';

class AppConfig {
  AppConfig._();

  static final GetStorage _storage = GetStorage();

  static Widget getDisplayImg(
    String? usrcode, {
    double size = 45,
    bool hasDP = false,
  }) {
    var imageUrl = '$assetURL/images/avatars/$usrcode.jpg';
    var defaultImg = '$assetURL/images/avatar.jpg';

    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.network(
          hasDP ? imageUrl : defaultImg,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.person, size: 45, color: Colors.grey),
        ),
      ),
    );
  }


  static Widget mkStatusMsg(String msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 32, 31, 31)),
      ),
    );
  }

  static Widget _defaultPlaceholder(double size, Color? backgroundColor) {
    return Container(
      width: size,
      height: size,
      color: backgroundColor ?? Colors.grey.shade200,
      child: Icon(Icons.person, size: size * 0.6, color: Colors.grey.shade600),
    );
  }

  // Compute initials from full name
  static String getInitials(String? fullName, {int maxChars = 2}) {
    if (fullName == null || fullName.trim().isEmpty) return '';
    final parts = fullName.trim().split(RegExp(r'\s+'));
    final initials = <String>[];
    for (var i = 0; i < parts.length && initials.length < maxChars; i++) {
      final p = parts[i];
      if (p.isNotEmpty) initials.add(p[0].toUpperCase());
    }
    return initials.join();
  }

  // Simple email validation
  static bool isValidEmail(String? email) {
    if (email == null) return false;
    final regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(email.trim());
  }

  // Simple phone formatter: strips non-digits and optionally applies country code prefix
  static String formatPhone(String phone, {String? countryCode}) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (countryCode == null || countryCode.isEmpty) return digits;
    return countryCode + digits;
  }
}
