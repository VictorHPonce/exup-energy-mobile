import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import 'dart:io';

class UiUtils {
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: TextStyle(
            color: colorScheme.onInverseSurface, 
            fontWeight: FontWeight.w500
          )
        ),
        backgroundColor: isError ? colorScheme.error : colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppTheme.paddingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM)
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
      final fallbackUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
    }
  }
}