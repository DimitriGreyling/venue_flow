
import 'package:flutter/material.dart';

typedef DeferredLoader = Future<void> Function();

class Responsive extends StatelessWidget {
  // Builders prevent deferred widgets from being constructed too early.
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder desktop;

  // Optional loaders. Leave null for normal, non-deferred widgets.
  final DeferredLoader? loadMobile;
  final DeferredLoader? loadTablet;
  final DeferredLoader? loadDesktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.loadMobile,
    this.loadTablet,
    this.loadDesktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
          MediaQuery.sizeOf(context).width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final WidgetBuilder selectedBuilder;
        final DeferredLoader? selectedLoader;

        if (width >= 1200) {
          selectedBuilder = desktop;
          selectedLoader = loadDesktop;
        } else if (width >= 600 && tablet != null) {
          selectedBuilder = tablet!;
          selectedLoader = loadTablet;
        } else {
          selectedBuilder = mobile;
          selectedLoader = loadMobile;
        }

        // Normal widgets need no deferred-loading logic.
        if (selectedLoader == null) {
          return selectedBuilder(context);
        }

        return _DeferredLayout(
          key: ValueKey(selectedBuilder),
          loader: selectedLoader,
          builder: selectedBuilder,
        );
      },
    );
  }
}

class _DeferredLayout extends StatefulWidget {
  final DeferredLoader loader;
  final WidgetBuilder builder;

  const _DeferredLayout({
    super.key,
    required this.loader,
    required this.builder,
  });

  @override
  State<_DeferredLayout> createState() => _DeferredLayoutState();
}

class _DeferredLayoutState extends State<_DeferredLayout> {
  late Future<void> _loading;

  @override
  void initState() {
    super.initState();
    _loading = widget.loader();
  }

  @override
  void didUpdateWidget(covariant _DeferredLayout oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.loader != widget.loader) {
      _loading = widget.loader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loading,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Failed to load this layout.'),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _loading = widget.loader();
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return widget.builder(context);
      },
    );
  }
}
