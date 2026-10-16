import 'package:flutter/material.dart';

class GenericLoader extends StatefulWidget {
  const GenericLoader({
    super.key,
    this.message = 'Preparing your experience...',
    this.fullScreen = false,
    this.size = 88,
  });

  final String message;
  final bool fullScreen;
  final double size;

  @override
  State<GenericLoader> createState() => _GenericLoaderState();
}

class _GenericLoaderState extends State<GenericLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.92,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotation = Tween<double>(
      begin: -0.04,
      end: 0.04,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final loader = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotation.value,
              child: Transform.scale(
                scale: _scale.value,
                child: child,
              ),
            );
          },
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(
                widget.size * 0.30,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.16),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Icons.location_on_rounded,
              size: widget.size * 0.52,
              color: colors.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'VenueFlow',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 22),
        SizedBox(
          width: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              minHeight: 4,
            ),
          ),
        ),
      ],
    );

    if (!widget.fullScreen) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: loader,
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: loader,
        ),
      ),
    );
  }
}