import 'package:flutter/material.dart';
import 'package:upsc_wars_new/features/home/domain/entities/pyq_year.dart';

/// Static list of UPSC Previous Year Question sets (2020–2025).
///
/// To add a year: append a new [PYQYear] entry here.
abstract final class PYQYearsDataSource {
  static final List<PYQYear> all = [
    PYQYear(year: 2025, color: const Color(0xFFE53935)),
    PYQYear(year: 2024, color: const Color(0xFFFF6D00)),
    PYQYear(year: 2023, color: const Color(0xFFFDD835)),
    PYQYear(year: 2022, color: const Color(0xFF1E88E5)),
    PYQYear(year: 2021, color: const Color(0xFF2E7D32)),
    PYQYear(year: 2020, color: const Color(0xFF8E24AA)),
  ];
}
