import 'package:flutter_bloc/flutter_bloc.dart'; // Importante
import 'package:go_router/go_router.dart';
import '../../injection_container.dart'; // Para usar el service locator 'sl'
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(), // La crearemos
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(), // La meta tras el login
    ),
  ],
);