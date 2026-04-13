// lib/views/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../theme/components.dart';
import '../../theme/spacing.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    final authState = ref.watch(authViewModelProvider);

    // Listen for auth changes
    ref.listen(authViewModelProvider, (previous, next) {
      if (next.isAuthenticated) {
        // Navigate based on user role
        final user = next.user;
        if (user?.isCoordinator == true) {
          context.goNamed('coordinator-dashboard');
        } else {
          context.goNamed('client-dashboard');
        }
      }
    });

    if(authState.isAuthenticated){
      if(authState.user != null && authState.user!.isCoordinator){
        context.goNamed('coordinator-dashboard');
      }else{
        context.goNamed('client-dashboard');
      }
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(EditorialSpacing.spacing8),
          child: EditorialComponents.editorialCard(
            colorScheme: colorScheme,
            padding: const EdgeInsets.all(EditorialSpacing.spacing8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Welcome Back',
                    style: editorial.venueNameStyle,
                  ),
                  const SizedBox(height: EditorialSpacing.spacing2),
                  Text(
                    'Sign in to your venue management account',
                    style: editorial.metadataStyle,
                  ),
                  const SizedBox(height: EditorialSpacing.spacing8),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: EditorialSpacing.spacing4),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: EditorialSpacing.spacing2),

                  // Error Message
                  if (authState.error != null)
                    Container(
                      padding: const EdgeInsets.all(EditorialSpacing.spacing3),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        authState.error!,
                        style: TextStyle(color: colorScheme.onErrorContainer),
                      ),
                    ),
                  const SizedBox(height: EditorialSpacing.spacing6),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authState.isLoading ? null : _handleSignIn,
                      child: authState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: EditorialSpacing.spacing4),

                  // Sign Up Link
                  Center(
                    child: TextButton(
                      onPressed: () => context.goNamed('signup'),
                      child: Text(
                        'Need an account? Sign up',
                        style: editorial.linkStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() == true) {
      ref.read(authViewModelProvider.notifier).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}