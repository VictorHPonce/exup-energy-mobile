import 'package:exup_energy_mobile/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return BrandText.caption(
      title.toUpperCase(),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}