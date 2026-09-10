import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/app/theme/app_colors.dart';
import 'package:venue_flow_app/core/error/failure.dart';
import 'package:venue_flow_app/features/login/application/auth_controller.dart';
import 'package:venue_flow_app/features/login/domain/auth_session.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthSession?>>(authControllerProvider, (_, next) {
      if (!mounted || next.isLoading) {
        return;
      }

      final session = next.valueOrNull;
      if (session != null) {
        context.go('/dashboard');
        return;
      }

      if (next.hasError) {
        final error = next.error;
        final message = error is Failure ? error.message : error.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isSubmitting = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.neutral200),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(17, 24, 39, 0.04),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;

                  if (isWide) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: _BrandPanel(),
                        ),
                        Expanded(
                          flex: 4,
                          child: _LoginForm(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            rememberMe: _rememberMe,
                            onTogglePassword: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            onRememberChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            isSubmitting: isSubmitting,
                            onSubmit: () async {
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      _BrandPanel(),
                      _LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        obscurePassword: _obscurePassword,
                        rememberMe: _rememberMe,
                        onTogglePassword: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        onRememberChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        isSubmitting: isSubmitting,
                        onSubmit: () async {
                          await ref.read(authControllerProvider.notifier).signIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          bottomLeft: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/venue_flow_mark_transparent.svg',
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      AppColors.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'VenueFlow',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            'Control every room, event, and booking in real time.',
            style: theme.textTheme.displaySmall?.copyWith(
              color: AppColors.onPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Keep operations aligned across venues, teams, and event schedules with live visibility and proactive planning.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          const _InsightTile(
            label: 'Live occupancy',
            value: '86.4%',
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _InsightTile(
                  label: 'Revenue',
                  value: '\$48.2k',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _InsightTile(
                  label: 'Bookings',
                  value: '134',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.isSubmitting,
    required this.onTogglePassword,
    required this.onRememberChanged,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final bool isSubmitting;
  final VoidCallback onTogglePassword;
  final ValueChanged<bool?> onRememberChanged;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: theme.textTheme.displaySmall?.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to access your venue operations workspace.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Email address',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'you@venueflow.com',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Password',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: onTogglePassword,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: onRememberChanged,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const Text('Remember me'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isSubmitting ? null : onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.onPrimary,
                        ),
                      ),
                    )
                  : const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or continue with',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata_rounded),
                  label: const Text('Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: AppColors.neutral200),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple_rounded),
                  label: const Text('Apple'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: AppColors.neutral200),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Request access'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}