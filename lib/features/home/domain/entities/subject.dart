import 'package:flutter/material.dart';
import 'package:upsc_wars_new/l10n/app_localizations.dart';

/// A single UPSC subject shown in the subject list.
///
/// [color] is the subject's accent color — used directly for the icon and,
/// at reduced opacity, for the tile background. Both modes are handled in the
/// widget layer so this entity stays presentation-agnostic.
class Subject {
  const Subject({
    required this.id,
    required this.icon,
    required this.color,
    required this.name,
  });

  final String id;
  final IconData icon;

  /// The subject's brand color. Choose a vivid shade — the widget will
  /// desaturate it appropriately for light / dark backgrounds.
  final Color color;

  /// Returns the localized display name for this subject.
  final String Function(AppLocalizations) name;
}
