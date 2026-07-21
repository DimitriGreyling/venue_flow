import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      if (next.hasValue) context.go('/customers');
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    final theme = Theme.of(context);

    return Scaffold(
      appBar: null, //AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            // TextField(controller: password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: authState.isLoading
            //       ? null
            //       : () => ref.read(authControllerProvider.notifier).login(email.text, password.text),
            //   child: authState.isLoading
            //       ? const CircularProgressIndicator()
            //       : const Text('Login'),
            // )
            Center(
              child: Card(
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Venue Flow",
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                      Text("Sign In",style: theme.textTheme.headlineMedium,),
                      Text('Access your venue management dashboard'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
