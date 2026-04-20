import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importamos nuestros Átomos y Moléculas
import '../../../../core/widgets/atoms/brand_text.dart';
import '../../../../core/widgets/atoms/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Importante para no chocar con el notch del móvil
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2), // Espacio flexible para empujar el logo
              // Átomo: Icono (En el futuro será tu Logo en imagen)
              const Icon(
                Icons.bolt_rounded,
                size: 100,
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 24),

              // Átomo: Texto de Marca (Header)
              const BrandText.header('ExUp Energy'),

              const SizedBox(height: 12),

              // Átomo: Texto de Marca (Body)
              const BrandText.body(
                'Encuentra la mejor energía para tu camino',
                textAlign: TextAlign.center,
              ),

              const Spacer(
                flex: 3,
              ), // Más espacio en el centro para balance visual
              // Átomo: Botón Primario (Acción Principal)
              PrimaryButton(
                text: 'Iniciar Sesión',
                onPressed: () => context.push('/login'),
              ),

              const SizedBox(height: 16),

              // Molécula: Botón de texto simple (Acción Secundaria)
              TextButton(
                onPressed: () => context.go('/home'), // Navegación directa
                child: const Text(
                  'Explorar sin cuenta',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(), // Empuja el footer al final
              // Molécula: Footer de registro
              _buildFooter(context),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Molécula interna: Solo se usa aquí, no necesita archivo aparte por ahora
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BrandText.caption('¿Eres nuevo? '),
        GestureDetector(
          onTap: () => context.push('/register'),
          child: const Text(
            'Crea una cuenta aquí',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
