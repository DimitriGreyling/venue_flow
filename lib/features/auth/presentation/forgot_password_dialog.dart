import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/domain/response_object.dart';

class ForgotPasswordDialog extends ConsumerStatefulWidget {
  final Future<ResponseObject<String>> Function(String email) onSubmit;

  const ForgotPasswordDialog({super.key, required this.onSubmit});

  @override
  ConsumerState<ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await widget.onSubmit(_emailController.text.trim());

      if (!mounted) return;

      if (response.success) {
        setState(() {
          _isSuccess = true;
          _successMessage =
              response.message ??
              response.data ??
              'If an account exists, password reset instructions will be sent.';
        });
      } else {
        setState(() {
          _errorMessage =
              response.message ??
              'Unable to process your request. Please try again.';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Something went wrong. Please try again later.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isSuccess ? _buildSuccessContent() : _buildFormContent(),
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),

          const Icon(Icons.lock_reset_rounded, size: 42),

          const SizedBox(height: 16),

          Text(
            'Forgot password?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: 8),

          Text(
            'No worries! Enter your email address and we will '
            'send you instructions to reset your password.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(
              labelText: 'Email address',
              hintText: 'example@email.com',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }

              return null;
            },
          ),

          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Send reset link'),
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _isLoading ? null : () => Navigator.pop(context),
              child: const Text('Back to login'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.mark_email_read_outlined,
          size: 56,
          color: Colors.green,
        ),

        const SizedBox(height: 20),

        Text(
          'Check your email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 12),

        Text(
          _successMessage ??
              'If an account exists, password reset instructions will be sent.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to login'),
          ),
        ),
      ],
    );
  }
}
