import 'package:flutter/material.dart';
import '../atoms/brand_text.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isGuest;

  const CustomDrawerHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor,
            theme.primaryColor.withBlue(200),
          ],
        ),
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Icon(
                isGuest ? Icons.person_outline : Icons.person,
                size: 35,
                color: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BrandText.header(name, color: Colors.white),
          BrandText.caption(email, color: Colors.white.withValues(alpha: 0.8)),
        ],
      ),
    );
  }
}