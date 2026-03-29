import 'package:flutter/material.dart';

/// A single Previous Year Questions entry shown in the PYQ list.
///
/// [color] is the year card's accent color — used for the top strip and,
/// at reduced opacity, for the card background.
class PYQYear {
  const PYQYear({
    required this.year,
    required this.color,
  });

  /// The exam year (e.g. 2025).
  final int year;

  /// The card's accent color. Choose a vivid shade — the widget desaturates
  /// it for light / dark backgrounds.
  final Color color;
}
