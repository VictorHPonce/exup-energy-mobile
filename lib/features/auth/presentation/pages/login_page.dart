import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2. Inyectamos el BLoC en el árbol de widgets
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ExUp Energy - Login')),
        body: BlocConsumer<AuthBloc, AuthState>(
          // El 'listener' sirve para acciones que no son dibujar (navegar, mostrar snackbars)
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('¡Bienvenido ${state.user.name}!')),
              );
              // Aquí navegarías a la Home más adelante
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          // El 'builder' sirve para dibujar la UI según el estado
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  
                  // 3. Si el estado es de carga, mostramos el spinner, si no, el botón
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        // 4. Disparamos el evento al BLoC
                        context.read<AuthBloc>().add(
                              LoginSubmittedEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                      },
                      child: const Text('Entrar'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Es buena práctica limpiar los controladores como en el ngOnDestroy
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}