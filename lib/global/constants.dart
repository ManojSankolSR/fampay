import 'dart:ui';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Constants {
  static double scrollViewHorizontalPadding = 15;

  static FontWeight getFontWeightFromFamily(String? fontFamily) {
  switch (fontFamily) {
    case 'met_semi_bold':
      return FontWeight.w600;  // Semi-bold weight
    case 'met_bold':
      return FontWeight.w700;  // Bold weight
    case 'met_regular':
      return FontWeight.w400;  // Regular weight
    case 'met_light':
      return FontWeight.w300;  // Light weight
    case 'met_thin':
      return FontWeight.w100;  // Thin weight
    default:
      return FontWeight.normal;  // Default to normal if unknown
  }
}




static TextDecoration getTextDecorationFromStyle(String? fontStyle) {
  switch (fontStyle?.toLowerCase()) {
    case 'underline':
      return TextDecoration.underline;
    case 'lineThrough':
      return TextDecoration.lineThrough;
    case 'none':
      return TextDecoration.none;
    default:
      return TextDecoration.none; 
  }
}


  static Future launchUrl(String? url, BuildContext context) async {

    if (url == null || url.trim().isEmpty) {
      customToast(title: "No Url Found", icon: Icons.warning_amber)
          .show(context);
    } else {
      if (!await launchUrlString(url) && context.mounted) {
        customToast(title: "Some Error Occured", icon: Icons.warning_amber)
            .show(context);
      }
    }
  }

  static DelightToastBar customToast(
      {required String title, required IconData icon}) {
    return DelightToastBar(
      position: DelightSnackbarPosition.top,


      builder: (context) => ToastCard(
        color: Colors.white,
        title: Text(title),
        leading: Icon(icon),
      ),
    );
  }

  static Color hexToColorWithAlpha(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      return Color(int.parse('0xFF$hex')); // No alpha, default to full opacity
    } else if (hex.length == 8) {
      return Color(int.parse('0x$hex')); // Includes alpha (8 characters)
    } else {
      throw FormatException('Invalid hex color format');
    }
  }

  static TextAlign getTextAlignFromString(String? align) {
    switch (align?.toLowerCase()) {
      case "center":
        return TextAlign.center;
      case "right":
        return TextAlign.right;
      case "left":
      default:
        return TextAlign.left;
    }
  }

  static MainAxisAlignment getMainAxisAlignmentFromString(String? alignment) {
    switch (alignment?.toLowerCase()) {
      case "center":
        return MainAxisAlignment.center;
      case "right":
        return MainAxisAlignment.end;
      case "left":
      default:
        return MainAxisAlignment.start;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignmentFromString(String? alignment) {
    switch (alignment?.toLowerCase()) {
      case "center":
        return CrossAxisAlignment.center;
      case "right":
        return CrossAxisAlignment.end;
      case "left":
      default:
        return CrossAxisAlignment.start;
    }
  }
}
