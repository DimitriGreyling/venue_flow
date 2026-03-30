import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';
import 'views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(lightSystemUiStyle);
  
  runApp(
    const ProviderScope(
      child: EditorialConciergeApp(),
    ),
  );
}

class EditorialConciergeApp extends ConsumerWidget {
  const EditorialConciergeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    // Update system UI overlay style when theme changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(getSystemUiStyle(themeMode));
    });

    return MaterialApp(
      title: 'Venue Flow - The Editorial Concierge',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: editorialLightTheme,
      darkTheme: editorialDarkTheme,
      themeMode: themeMode,
      
      // High performance settings
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling, // Prevent text scaling issues
          ),
          child: child!,
        );
      },
      
      home: const HomePage(),
    );
  }
}
