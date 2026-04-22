import 'package:exup_energy_mobile/features/auth/auth.dart';
import 'package:exup_energy_mobile/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/gas_stations/presentation/bloc/stations_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()..add(AppStarted())),
        BlocProvider<StationsBloc>(create: (_) => di.sl<StationsBloc>()),
        BlocProvider<UserBloc>(create: (_) => di.sl<UserBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'ExUp Energy',
        debugShowCheckedModeBanner: false,
        
        themeMode: ThemeMode.system, 
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}