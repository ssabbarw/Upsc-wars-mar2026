import 'package:flutter/material.dart';
import 'package:upsc_wars_new/core/utils/responsive.dart';

/// Search field for filtering topic / sub-topic / concept labels.
class TopicWiseTagSearchBar extends StatelessWidget {
  /// Creates the search bar.
  const TopicWiseTagSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.accentColor,
  });

  /// Text controller (owned by parent).
  final TextEditingController controller;

  /// Hint when empty.
  final String hintText;

  /// Focus ring / icon tint.
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderRadius = BorderRadius.circular(context.wp(4));

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: context.sp(15),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              fontSize: context.sp(15),
              color: colorScheme.onSurfaceVariant.withAlpha(160),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: accentColor.withAlpha(200),
              size: context.sp(22),
            ),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      size: context.sp(22),
                      color: colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest.withAlpha(
              theme.brightness == Brightness.dark ? 80 : 110,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: context.hp(1.4),
              horizontal: context.wp(1),
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: colorScheme.outline.withAlpha(55),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: accentColor, width: 2),
            ),
          ),
        );
      },
    );
  }
}
