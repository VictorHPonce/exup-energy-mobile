import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../injection_container.dart';

final appRouter = GoRouter(
  initialLocation: '/welcome',
  // GUARD / REDIRECT LOGIC
  redirect: (context, state) async {
    final localDataSource = sl<AuthLocalDataSource>();
    final token = await localDataSource.getToken();
    
    // Lista de rutas que NO requieren autenticación
    final bool isLoggingIn = state.matchedLocation == '/login' || 
                             state.matchedLocation == '/register' || 
                             state.matchedLocation == '/welcome';

    if (token == null) {
      // Si no hay token y no estoy en una página pública, al welcome
      return isLoggingIn ? null : '/welcome';
    }

    if (isLoggingIn) {
      // Si ya tengo token y trato de ir al login, directo al home
      return '/home';
    }

    return null; // No hay redirección, permite el paso
  },
  routes: [
    GoRoute(
      path: '/welcome', 
      builder: (context, state) => const WelcomePage()
    ),
    GoRoute(
      path: '/login', 
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(
      path: '/register', 
      builder: (context, state) => const RegisterPage()
    ),
    GoRoute(
      path: '/home', 
      builder: (context, state) => const HomePage(), 
    ),
  ],
);