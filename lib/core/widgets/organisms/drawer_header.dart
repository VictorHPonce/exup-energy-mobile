import 'package:flutter/material.dart';
import 'package:exup_energy_mobile/core/theme/app_theme.dart';
import '../atoms/brand_text.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isGuest;
  final String? imageUrl;       
  final VoidCallback? onAvatarTap; 

  const CustomDrawerHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isGuest,
    this.imageUrl,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppTheme.paddingL, 
        AppTheme.headerPaddingTop, 
        AppTheme.paddingL, 
        AppTheme.paddingL
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.primaryContainer],
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(AppTheme.headerRadius)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: AppTheme.avatarOuterRadius,
                  backgroundColor: colorScheme.onPrimary.withValues(alpha: 0.2),
                  child: CircleAvatar(
                    radius: AppTheme.avatarInnerRadius,
                    backgroundColor: colorScheme.surface,
                    backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: (imageUrl == null || imageUrl!.isEmpty)
                        ? Icon(
                            isGuest ? Icons.person_outline : Icons.person,
                            size: AppTheme.avatarOuterRadius,
                            color: colorScheme.primary,
                          )
                        : null,
                  ),
                ),
                if (!isGuest && onAvatarTap != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: colorScheme.secondaryContainer,
                      child: Icon(Icons.camera_alt, size: 14, color: colorScheme.onSecondaryContainer),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.paddingM),
          BrandText.header(name, color: colorScheme.onPrimary),
          BrandText.caption(
            email, 
            color: colorScheme.onPrimary.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }
}