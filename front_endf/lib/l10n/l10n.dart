import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
    const Locale('fr'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return 'π©πΏ';

      case 'fr':
        return 'π«π·';

      case 'en':
      default:
        return 'πΊπΈ';

    }
  }
}

