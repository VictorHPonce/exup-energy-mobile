import 'package:go_router/go_router.dart';
import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/home/home.dart';
import '../../injection_container.dart';

final appRouter = GoRouter(
  initialLocation: '/welcome',
  redirect: (context, state) async {
    final localDataSource = sl<AuthLocalDataSource>();
    final token = await localDataSource.getToken();

    // MatchedLocation es el path actual
    final bool isLoggingIn =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register' ||
        state.matchedLocation == '/welcome';

    if (token == null && state.matchedLocation == '/home') {
      return null;
    }

    if (token == null) {
      return isLoggingIn ? null : '/welcome';
    }

    if (isLoggingIn) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/welcome', builder: (context, state) => const WelcomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
  ],
);
