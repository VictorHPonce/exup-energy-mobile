import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Para poner contenido sobre un fondo si quieres
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo (Usa un Icono temporalmente si no tienes imagen)
                const Icon(Icons.bolt, size: 100, color: Colors.blueAccent),
                const SizedBox(height: 20),
                const Text(
                  'ExUp Energy',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Encuentra la mejor energía para tu camino',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 60),

                // 2. Botón Iniciar Sesión (Acción Principal)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => context.push('/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                ),
                const SizedBox(height: 15),

                // 3. Botón Explorar (Acción Secundaria)
                TextButton(
                  onPressed: () { /* Navegar al mapa directamente */ },
                  child: const Text('Explorar sin cuenta'),
                ),
                const Spacer(), // Empuja el resto hacia abajo

                // 4. Pie de página: ¿Eres nuevo?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Eres nuevo?'),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('Crea una cuenta aquí'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}