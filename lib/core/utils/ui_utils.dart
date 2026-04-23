import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import 'dart:io';

class UiUtils {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: colorScheme.onInverseSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: isError ? colorScheme.error : colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppTheme.paddingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<void> openNavigationMap(double lat, double lon) async {
    Uri uri;

    if (Platform.isAndroid) {
      uri = Uri.parse('google.navigation:q=$lat,$lon&mode=d');
    } else {
      uri = Uri.parse('http://maps.apple.com/?daddr=$lat,$lon');
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      final fallbackUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
      );
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  static void showCustomModal({
    required BuildContext context,
    required String title,
    required Widget child,
    String? subtitle,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusL),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.paddingL,
          left: AppTheme.paddingL,
          right: AppTheme.paddingL,
          top: AppTheme.paddingM,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // El "Handle" para deslizar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.paddingL),
            BrandText.header(title, fontSize: 22),
            if (subtitle != null) ...[
              const SizedBox(height: AppTheme.paddingS),
              BrandText.body(subtitle),
            ],
            const SizedBox(height: AppTheme.paddingL),
            child, // Aquí inyectamos el contenido específico
          ],
        ),
      ),
    );
  }

  static Widget sectionHeader(BuildContext context, String title) {
  return BrandText.caption(
    title.toUpperCase(),
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.primary,
  );
}
}
