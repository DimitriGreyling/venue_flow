# Editorial Concierge Theme System

A comprehensive Flutter theme system implementing "The Digital Curator" design language for premium wedding venue management applications. This theme system transforms standard software interfaces into sophisticated digital ateliers.

## Design Philosophy

The Editorial Concierge theme is built around the concept of **"The Digital Curator"** - moving away from spreadsheet-like management tools toward a high-end wedding planner's physical portfolio aesthetic.

### Key Principles

1. **Intentional Asymmetry** - Using spacing shifts between 16 and 20 to create editorial rather than industrial feel
2. **Tonal Breathability** - Expansive whitespace ensures interfaces never feel "busy"
3. **Layered Sophistication** - Overlapping elements create depth and curated intent
4. **The "No-Line" Rule** - Boundaries defined through background color shifts, not borders

## Features

- ✅ **Light & Dark Theme Support** - Seamless theme switching with persistence
- ✅ **Editorial Typography** - Noto Serif for editorial voice, Manrope for functional voice
- ✅ **Luxury Color System** - Deep slate, sophisticated earth, and gold accents
- ✅ **Surface Hierarchy** - "Layered vellum paper" effect with subtle depth
- ✅ **Premium Components** - Cards, buttons, inputs following luxury aesthetic
- ✅ **Glassmorphism Effects** - Backdrop blur for navigation and floating elements
- ✅ **Responsive Spacing** - Asymmetrical margins that adapt to screen size
- ✅ **Theme Provider** - Riverpod-based theme management with SharedPreferences

## Installation

1. Add dependencies to `pubspec.yaml`:
```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  google_fonts: ^6.3.0
  shared_preferences: ^2.3.2
```

2. Import the theme system:
```dart
import 'package:your_app/theme/theme.dart';
import 'package:your_app/theme/theme_provider.dart';
```

## Quick Start

### 1. Setup Theme Provider

Wrap your app with `ProviderScope` and configure the theme:

```dart
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp(
      theme: editorialLightTheme,
      darkTheme: editorialDarkTheme,
      themeMode: themeMode,
      home: MyHomePage(),
    );
  }
}
```

### 2. Access Theme Data

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial; // Custom editorial extensions
    
    return Text(
      'Venue Name',
      style: editorial.venueNameStyle,
    );
  }
}
```

### 3. Theme Switching

```dart
class ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(Icons.brightness_6),
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
    );
  }
}
```

## Typography System

### Editorial Voice (Noto Serif)
For statements, headlines, venue names - evokes tradition and elegance:
- `editorial.venueNameStyle` - Signature branding
- `editorial.quoteStyle` - Testimonials and featured quotes
- `Theme.of(context).textTheme.displayLarge` - Major headlines
- `Theme.of(context).textTheme.headlineMedium` - Section headers

### Functional Voice (Manrope)
For body text, labels, data - ensures high legibility:
- `editorial.metadataStyle` - Timestamps and secondary data
- `editorial.sectionHeaderStyle` - Categorical organization
- `Theme.of(context).textTheme.bodyLarge` - Main content
- `Theme.of(context).textTheme.labelMedium` - UI labels

## Color System

### Core Brand Colors
- **Primary (#446464)** - Deep Slate for actions and navigation
- **Secondary (#685d4a)** - Sophisticated earth tone bridge color
- **Tertiary (#735c00)** - Gold accent for highlights and "booked" status

### Surface Hierarchy
Following the "layered vellum paper" concept:
```dart
// Base layer
backgroundColor: colorScheme.surface

// Sectioning
backgroundColor: colorScheme.surfaceContainerLow

// Interactive cards
backgroundColor: colorScheme.surfaceContainerLowest

// Elevated elements
backgroundColor: colorScheme.surfaceContainerHigh
```

## Component Usage

### Editorial Cards
```dart
EditorialComponents.editorialCard(
  colorScheme: colorScheme,
  onTap: () {},
  child: YourContent(),
)
```

### Status Chips
```dart
EditorialComponents.statusChip(
  label: 'Booked',
  status: VenueStatus.booked,
  colorScheme: colorScheme,
)
```

### Quote Containers
```dart
EditorialComponents.quoteContainer(
  quote: "The beauty lies in the precision of the plan.",
  attribution: "Elena Vance",
  colorScheme: colorScheme,
)
```

### Section Headers
```dart
EditorialComponents.sectionHeader(
  title: 'Event Details',
  subtitle: 'Wedding coordination timeline',
  colorScheme: colorScheme,
)
```

## Spacing System

### Intentional Asymmetry
```dart
// Hero sections with editorial feel
Container(
  margin: EdgeInsets.only(
    left: EditorialSpacing.editorialHeroLeftLarge,
    right: EditorialSpacing.editorialHeroRightLarge,
  ),
  child: content,
)
```

### Breathability Spacing
```dart
// Major section breaks
SizedBox(height: EditorialSpacing.breathabilityMajor)

// Component breathing room  
SizedBox(height: EditorialSpacing.breathabilityMicro)
```

### List Spacing (No-Line Rule)
```dart
// Between list items (replaces dividers)
SizedBox(height: EditorialSpacing.listItemSpacing)
```

## Elevation & Shadows

### Ambient Shadows
```dart
Container(
  decoration: BoxDecoration(
    boxShadow: EditorialElevation.ambientShadow(isDark),
  ),
)
```

### Glassmorphism Effect
```dart
EditorialGlassContainer(
  isDark: Theme.of(context).brightness == Brightness.dark,
  child: NavigationContent(),
)
```

## Advanced Usage

### Custom Theme Extensions
Access specialized editorial styles:
```dart
final editorial = context.editorial;

Text('Quote', style: editorial.quoteStyle);
Text('METADATA', style: editorial.metadataStyle);
Text('Accent', style: editorial.accentTextStyle);
```

### Responsive Asymmetric Margins
```dart
final margins = EditorialResponsiveSpacing.editorialMargins(screenWidth);
Container(
  margin: EdgeInsets.only(
    left: margins.left,
    right: margins.right,
  ),
)
```

### Theme-Aware Shadows
```dart
Container(
  decoration: BoxDecoration().withEditorialShadow(
    EditorialShadowType.card,
    Theme.of(context).brightness == Brightness.dark,
  ),
)
```

## Design Guidelines

### Do's ✅
- Use asymmetrical margins for hero sections
- Prioritize Noto Serif for statements and venue names  
- Use surface-tint for empty state backgrounds
- Apply generous spacing to prevent crowded interfaces

### Don'ts ❌
- Don't use 100% black (#000000) for text
- Don't use rounded-none - everything should have soft edges
- Don't add 1px borders - use background color shifts instead
- Don't crowd interfaces - increase container size vs shrinking typography

## Theme Demo

Run the included theme demo to see all components and capabilities:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditorialThemeDemo(),
  ),
);
```

## File Structure

```
lib/theme/
├── theme.dart                 # Main theme exports
├── theme_provider.dart        # Riverpod theme management
├── colors.dart               # Light/dark color schemes
├── typography.dart           # Font system (Noto Serif + Manrope)
├── spacing.dart              # Asymmetric spacing system
├── elevation.dart            # Shadow and depth system
├── components.dart           # Component themes
└── editorial_theme_data.dart # Custom theme extensions
```

## Contributing

When extending this theme system:

1. Follow the "No-Line" rule - use spacing and color shifts instead of borders
2. Maintain the editorial vs functional voice distinction in typography
3. Preserve the asymmetrical spacing that creates the luxury feel
4. Test both light and dark modes
5. Ensure glassmorphism effects work across themes

## License

This theme system implements the Editorial Concierge design language for premium wedding venue management applications.