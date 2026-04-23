import 'package:exup_energy_mobile/core/widgets/organisms/drawer_header.dart';
import 'package:exup_energy_mobile/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/core.dart';
import '../../../user.dart';

class ProfileAvatarHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? profilePictureUrl;
  final bool isGuest;

  const ProfileAvatarHeader({
    super.key,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDrawerHeader(
      name: name,
      email: email,
      isGuest: isGuest,
      onAvatarTap: isGuest ? null : () => _showImageSourceSheet(context),
      imageUrl: profilePictureUrl, 
    );
  }

  void _showImageSourceSheet(BuildContext context) async {
    final pickerService = sl<ImagePickerService>();
    final theme = Theme.of(context);

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tomar Foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Elegir de Galería'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final image = await pickerService.pickAndCropImage(
        source: source,
        primaryColor: theme.primaryColor,
      );

      if (image != null && context.mounted) {
        context.read<UserBloc>().add(UpdateProfilePictureRequested(image));
      }
    }
  }
}