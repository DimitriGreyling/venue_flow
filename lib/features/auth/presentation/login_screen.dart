import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme_x.dart';
import 'auth_session.dart';

/// A production-ready, fully responsive Flutter implementation of the Venue Manager login screen.
/// Features a split-screen layout:
/// - Left side: Immersive visual hero banner with background image, dark gradient overlay, and quote.
/// - Right side: Deep indigo modern authentication card with custom styled inputs, social buttons, and typography.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final auth = ref.read(authSessionProvider.notifier);

    try {
      await auth.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      final session = ref.read(authSessionProvider);

      if (session.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              session.error?.toString() ?? 'Failed to sign in',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (session.value == true) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 900;
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    // Listen to auth state so the UI can react without setState for auth flow.
    ref.listen<AsyncValue<bool>>(authSessionProvider, (previous, next) {
      if (!mounted) return;

      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error?.toString() ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (next.value == true) {
        context.go('/venues');
      }
    });

    final isLoading = ref.watch(authSessionProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Flex(
                    direction: isDesktop ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: isDesktop ? 1 : 0,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: isDesktop ? constraints.maxHeight : 350,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=1200&q=80',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: const Color(0xFF4F46E5),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white54,
                                          size: 48,
                                        ),
                                      ),
                                    ),
                              ),
                              Container(
                                color: const Color(0xFF4F46E5).withOpacity(0.2),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                      Colors.black.withOpacity(0.85),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '"The most efficient way to scale our multi-venue operations across three continents."',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 2,
                                          color: const Color(0xFF4F46E5),
                                        ),
                                        const SizedBox(width: 16),
                                        const Expanded(
                                          child: Text(
                                            'Chief Operations Officer, Global Arena Group',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: isDesktop ? 1 : 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 64.0 : 24.0,
                            vertical: 48.0,
                          ),
                          alignment: Alignment.center,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Center(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 420),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4F46E5),
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color(0xFF4F46E5)
                                                        .withOpacity(0.3),
                                                    blurRadius: 16,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.dashboard_rounded,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            const Text(
                                              'Venue Flow',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 32),
                                        const Text(
                                          'Welcome back',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Login to manage your venues',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        Text(
                                          'EMAIL ADDRESS',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                            color: sem.textMuted,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: _buildInputDecoration(
                                            cs: cs,
                                            hintText: 'admin@venue.com',
                                            prefixIcon: Icons.mail_outline_rounded,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !value.contains('@')) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'PASSWORD',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: const Text(
                                                'Forgot Password?',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          decoration: _buildInputDecoration(
                                            cs: cs,
                                            hintText: '••••••••',
                                            prefixIcon: Icons.lock_outline_rounded,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscurePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscurePassword =
                                                  !_obscurePassword;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value.length < 6) {
                                              return 'Password must be at least 6 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 54,
                                          child: ElevatedButton(
                                            onPressed: isLoading
                                                ? null
                                                : _handleSignIn,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              const Color(0xFF4F46E5),
                                              foregroundColor: Colors.white,
                                              elevation: 6,
                                              shadowColor: const Color(0xFF4F46E5)
                                                  .withOpacity(0.4),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: isLoading
                                                ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child:
                                              CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                                : const Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 32.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.white12,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                ),
                                                child: Text(
                                                  'OR CONTINUE WITH',
                                                  style: TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.0,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.white12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _buildSocialButton(
                                                cs: cs,
                                                label: 'Google',
                                                iconPath: 'assets/google.webp',
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 48),
                                        Center(
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              const Text(
                                                "Don't have an account? ",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Text(
                                                  'Contact your administrator',
                                                  style: TextStyle(
                                                    color: Color(0xFF4F46E5),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required ColorScheme cs,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: cs.onSurface.withValues(alpha: 0.6),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: cs.onSurface.withValues(alpha: 0.6),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: cs.inversePrimary.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required String iconPath,
    required VoidCallback onPressed,
    required ColorScheme cs,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.onSurface,
        backgroundColor: cs.onSurface.withOpacity(0.05),
        side: BorderSide(color: cs.onSurface.withOpacity(0.1)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            iconPath,
            height: 18,
            width: 18,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.security, size: 18, color: cs.onSurface),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}