import 'package:exup_energy_mobile/features/auth/presentation/pages/welcome_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
// Importa aquí tus otras páginas (Welcome, Register, etc.)

final appRouter = GoRouter(
  initialLocation: '/welcome', // Empezamos por la pantalla de marca
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(), // La crearemos ahora
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    // GoRoute(path: '/register', ...),
  ],
);