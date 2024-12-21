import 'dart:math';
import 'dart:ui';
import 'package:fampay/global/constants.dart';
import 'package:flutter/material.dart';

class GradientData {
  final double angle;
  final List<Color> colors;

  GradientData({required this.angle, required this.colors});

  // Factory constructor to create an instance from JSON
  factory GradientData.fromJson(Map<String, dynamic> json) {
    List<String> colorHexes = List<String>.from(json["colors"]);
    List<Color> colors = colorHexes.map((hex) => Constants.hexToColorWithAlpha(hex)).toList();
    return GradientData(
      angle: json["angle"].toDouble(),
      colors: colors,
    );
  }

  // Converts the angle into Flutter's alignment values
  AlignmentGeometry getAlignmentFromAngle(double angle) {
    double radians = angle * (pi / 180);
    double x = cos(radians);
    double y = sin(radians);
    return Alignment(x, y);
  }

  // Get the linear gradient object from the gradient data
  LinearGradient toLinearGradient() {
    AlignmentGeometry begin = getAlignmentFromAngle(angle);
    AlignmentGeometry end = getAlignmentFromAngle(angle + 180);
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
    );
  }
}
