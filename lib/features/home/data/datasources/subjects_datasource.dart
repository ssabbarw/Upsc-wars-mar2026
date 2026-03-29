import 'package:flutter/material.dart';
import 'package:upsc_wars_new/features/home/domain/entities/subject.dart';

/// Static list of UPSC subjects.
///
/// To add a subject: append a new [Subject] entry here and add the
/// corresponding ARB key to lib/l10n/app_en.arb + app_hi.arb, then
/// run `flutter gen-l10n`.
abstract final class SubjectsDataSource {
  /// Returns the [Subject] with [Subject.id] equal to [id], or `null`.
  static Subject? tryById(String id) {
    for (final Subject s in all) {
      if (s.id == id) return s;
    }
    return null;
  }

  static final List<Subject> all = [
    Subject(
      id: 'geography',
      icon: Icons.public_rounded,
      color: const Color(0xFF1E88E5), // Blue
      name: (l10n) => l10n.subjectGeography,
    ),
    Subject(
      id: 'modern_history',
      icon: Icons.history_edu_rounded,
      color: const Color(0xFFFF6D00), // Deep Orange
      name: (l10n) => l10n.subjectModernHistory,
    ),
    Subject(
      id: 'polity',
      icon: Icons.account_balance_rounded,
      color: const Color(0xFF8E24AA), // Purple
      name: (l10n) => l10n.subjectPolity,
    ),
    Subject(
      id: 'medieval_history',
      icon: Icons.fort_rounded,
      color: const Color(0xFF6D4C41), // Brown
      name: (l10n) => l10n.subjectMedievalHistory,
    ),
    Subject(
      id: 'art_and_culture',
      icon: Icons.palette_rounded,
      color: const Color(0xFFD81B60), // Pink
      name: (l10n) => l10n.subjectArtAndCulture,
    ),
    Subject(
      id: 'economics',
      icon: Icons.trending_up_rounded,
      color: const Color(0xFF2E7D32), // Green
      name: (l10n) => l10n.subjectEconomics,
    ),
    Subject(
      id: 'environment',
      icon: Icons.eco_rounded,
      color: const Color(0xFF00897B), // Teal
      name: (l10n) => l10n.subjectEnvironment,
    ),
    Subject(
      id: 'ancient_history',
      icon: Icons.museum_rounded,
      color: const Color(0xFFF9A825), // Amber/Gold
      name: (l10n) => l10n.subjectAncientHistory,
    ),
  ];
}
