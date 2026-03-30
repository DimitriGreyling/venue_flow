import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme.dart';
import '../theme/theme_provider.dart';
import '../theme/components.dart';
import '../theme/spacing.dart';

/// Demo widget showcasing Editorial Concierge theme capabilities
/// Shows typography, colors, components, and theme switching
class EditorialThemeDemo extends ConsumerWidget {
  const EditorialThemeDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;
    final themeMode = ref.watch(themeModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Editorial Concierge Theme Demo', style: editorial.venueNameStyle),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark 
                  ? Icons.light_mode_outlined 
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(EditorialSpacing.spacing6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Showcase
            EditorialComponents.sectionHeader(
              title: 'Typography System',
              subtitle: 'Noto Serif for Editorial Voice, Manrope for Functional Voice',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: EditorialSpacing.spacing6),
            
            _buildTypographyShowcase(context, colorScheme, editorial),
            
            const SizedBox(height: EditorialSpacing.breathabilityMajor),
            
            // Color Palette
            EditorialComponents.sectionHeader(
              title: 'Color System',
              subtitle: 'Surface hierarchy and editorial color scheme',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: EditorialSpacing.spacing6),
            
            _buildColorPalette(colorScheme, editorial),
            
            const SizedBox(height: EditorialSpacing.breathabilityMajor),
            
            // Component Showcase
            EditorialComponents.sectionHeader(
              title: 'Components',
              subtitle: 'Following the "No-Line" rule and luxury aesthetic',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: EditorialSpacing.spacing6),
            
            _buildComponentShowcase(colorScheme, editorial),
            
            const SizedBox(height: EditorialSpacing.breathabilityMajor),
            
            // Quote Example
            EditorialComponents.quoteContainer(
              quote: "The beauty of the day lies in the precision of the plan.",
              attribution: "Elena Vance, Wedding Coordinator",
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyShowcase(
    BuildContext context,
    ColorScheme colorScheme, 
    EditorialThemeData editorial,
  ) {
    return EditorialComponents.editorialCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Display Large - Editorial Voice', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Headline Medium - Editorial Voice', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Title Large - Editorial Voice', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Body Large - Functional Voice', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('LABEL MEDIUM - FUNCTIONAL VOICE', style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Venue Name Style', style: editorial.venueNameStyle),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Quote Style - Editorial elegance', style: editorial.quoteStyle),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('METADATA STYLE', style: editorial.metadataStyle),
        ],
      ),
    );
  }

  Widget _buildColorPalette(ColorScheme colorScheme, EditorialThemeData editorial) {
    return EditorialComponents.editorialCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _colorSwatch('Primary', colorScheme.primary),
              _colorSwatch('Secondary', colorScheme.secondary),
              _colorSwatch('Tertiary', colorScheme.tertiary),
              _colorSwatch('Error', colorScheme.error),
            ],
          ),
          const SizedBox(height: EditorialSpacing.spacing4),
          Text('Surface Hierarchy (Layered Vellum Paper)', style: editorial.sectionHeaderStyle),
          const SizedBox(height: EditorialSpacing.spacing2),
          Row(
            children: [
              _colorSwatch('Surface', colorScheme.surface),
              _colorSwatch('ContainerLow', colorScheme.surfaceContainerLow),
              _colorSwatch('Container', colorScheme.surfaceContainer),
              _colorSwatch('ContainerHigh', colorScheme.surfaceContainerHigh),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorSwatch(String name, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          const SizedBox(height: EditorialSpacing.spacing1),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentShowcase(ColorScheme colorScheme, EditorialThemeData editorial) {
    return EditorialComponents.editorialCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buttons
          Wrap(
            spacing: EditorialSpacing.spacing4,
            runSpacing: EditorialSpacing.spacing2,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Primary Button'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Secondary Button'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Tertiary Button'),
              ),
            ],
          ),
          
          const SizedBox(height: EditorialSpacing.spacing6),
          
          // Status Chips
          Wrap(
            spacing: EditorialSpacing.spacing2,
            children: [
              EditorialComponents.statusChip(
                label: 'Available',
                status: VenueStatus.available,
                colorScheme: colorScheme,
              ),
              EditorialComponents.statusChip(
                label: 'Hold',
                status: VenueStatus.hold,
                colorScheme: colorScheme,
              ),
              EditorialComponents.statusChip(
                label: 'Booked',
                status: VenueStatus.booked,
                colorScheme: colorScheme,
              ),
            ],
          ),
          
          const SizedBox(height: EditorialSpacing.spacing6),
          
          // Input Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Event Details',
              hintText: 'Enter venue information...',
            ),
          ),
        ],
      ),
    );
  }
}