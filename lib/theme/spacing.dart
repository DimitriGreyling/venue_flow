/// Editorial Concierge Spacing System
/// Implements intentional asymmetry for editorial feel rather than industrial precision
/// "Using the Spacing Scale (specifically shifts between 16 and 20) to create offset layouts"
class EditorialSpacing {
  EditorialSpacing._();

  // Base spacing units (standard progression)
  static const double spacing1 = 4.0;   // 0.25rem
  static const double spacing2 = 8.0;   // 0.5rem
  static const double spacing3 = 12.0;  // 0.75rem
  static const double spacing4 = 16.0;  // 1rem
  static const double spacing5 = 20.0;  // 1.25rem
  static const double spacing6 = 24.0;  // 1.5rem
  static const double spacing7 = 28.0;  // 1.75rem
  static const double spacing8 = 32.0;  // 2rem
  static const double spacing9 = 36.0;  // 2.25rem
  static const double spacing10 = 40.0; // 2.5rem
  static const double spacing12 = 48.0; // 3rem
  static const double spacing16 = 64.0; // 4rem
  static const double spacing20 = 80.0; // 5rem
  static const double spacing24 = 96.0; // 6rem

  // ARCHITECTURAL CORNER RADII - \"8px (DEFAULT) corner radius\" from design.md
  static const double defaultRadius = 8.0;     // DEFAULT - buttons, basic elements
  static const double cardRadius = 12.0;       // Cards - premium feel  
  static const double venueCardRadius = 24.0;  // XL - venue cards (1.5rem)
  static const double pillRadius = 9999.0;     // Action chips - pill shaped

  // INTENTIONAL ASYMMETRY - Editorial Layout Spacing
  /// "Use asymmetrical margins (e.g., 8.5rem on the left, 5.5rem on the right) for hero sections"
  /// These create the "digital atelier" rather than "spreadsheet" feel
  
  // Hero Section Asymmetry
  static const double editorialHeroLeftLarge = 136.0;  // 8.5rem
  static const double editorialHeroRightLarge = 88.0;  // 5.5rem
  static const double editorialHeroLeftMedium = 96.0;  // 6rem
  static const double editorialHeroRightMedium = 64.0; // 4rem
  static const double editorialHeroLeftSmall = 64.0;   // 4rem
  static const double editorialHeroRightSmall = 48.0;  // 3rem

  // Content Asymmetry for Editorial Feel
  /// These create the "curated intent" mentioned in the design
  static const double editorialContentOffsetLarge = 20.0;  // Primary offset
  static const double editorialContentOffsetSmall = 16.0;  // Secondary offset
  
  // Sidebar and Main Content Spacing
  static const double editorialSidebarWidth = 280.0;      // Sidebar width
  static const double editorialSidebarGap = 48.0;         // Gap between sidebar and main
  static const double editorialMainContentMax = 1024.0;   // Max content width

  // TONAL BREATHABILITY - Whitespace Management
  /// "Utilizing surface and ivory tones to create expansive whitespace"
  /// "ensuring the interface never feels busy despite complexity"
  
  // Generous section spacing
  static const double breathabilityMajor = 64.0;   // Major section breaks
  static const double breathabilityMinor = 32.0;   // Minor section breaks
  static const double breathabilityMicro = 16.0;   // Component breathing room

  // Content container spacing for "never feels busy" principle
  static const double expansiveVertical = 80.0;    // Vertical expansive spacing
  static const double expansiveHorizontal = 96.0;  // Horizontal expansive spacing

  // LAYERED SOPHISTICATION - Depth Spacing
  /// "Overlapping image containers with text blocks to create depth"
  
  // Overlap and layering offsets
  static const double layerOverlapLarge = -24.0;   // Negative spacing for overlaps
  static const double layerOverlapMedium = -16.0;  // Medium overlap
  static const double layerOverlapSmall = -8.0;    // Subtle overlap
  
  // Z-axis simulation through spacing
  static const double layerDepthBase = 0.0;        // Base layer
  static const double layerDepthCard = 4.0;        // Card elevation spacing
  static const double layerDepthModal = 12.0;      // Modal elevation spacing
  static const double layerDepthFloat = 8.0;       // Floating element spacing

  // COMPONENT SPECIFIC SPACING

  // Card and Container Spacing - "Soft, pillowy depth"
  static const double cardPadding = 24.0;          // Internal card padding
  static const double cardInternalSpacing = 16.0;  // Spacing within cards
  static const double cardExternalSpacing = 20.0;  // Spacing between cards (asymmetric)
  static const double cardBorderRadius = 8.0;      // Card corner radius

  // List Spacing - Implements "No-Line" Rule
  /// "Use spacing-4 (1.4rem) of vertical whitespace to separate items"
  /// "Forbid the use of divider lines between list items"
  static const double listItemSpacing = 22.4;      // Item separation (1.4rem)
  static const double listItemPadding = 16.0;      // Internal item padding
  static const double listSectionSpacing = 32.0;   // Section separation in lists

  // Form Field Spacing - "High-end paper form" aesthetic
  static const double formFieldSpacing = 20.0;     // Between form fields (asymmetric)
  static const double formFieldPadding = 16.0;     // Internal field padding
  static const double formLabelSpacing = 8.0;      // Label to field spacing
  static const double formSectionSpacing = 40.0;   // Between form sections

  // Button Spacing
  static const double buttonPadding = 24.0;        // Horizontal button padding
  static const double buttonPaddingVertical = 12.0; // Vertical button padding
  static const double buttonSpacing = 16.0;        // Space between buttons
  static const double buttonGroupSpacing = 8.0;    // Space within button groups

  // Navigation Spacing
  static const double navBarHeight = 64.0;         // Navigation bar height
  static const double navItemSpacing = 32.0;       // Space between nav items
  static const double navIconSpacing = 12.0;       // Space around nav icons
  
  // Timeline Specific Spacing (for the timeline component)
  static const double timelineItemSpacing = 48.0;  // Space between timeline items
  static const double timelineLineOffset = 32.0;   // Offset for timeline vertical line
  static const double timelineDotSize = 16.0;      // Timeline dot size
  static const double timelineCardPadding = 24.0;  // Timeline card internal padding

  // Responsive Breakpoints with Editorial Considerations
  static const double breakpointMobile = 480.0;    // Mobile layout
  static const double breakpointTablet = 768.0;    // Tablet layout
  static const double breakpointDesktop = 1024.0;  // Desktop layout
  static const double breakpointWide = 1440.0;     // Wide desktop layout

  // Safe Area and Edge Spacing
  static const double safeAreaPadding = 16.0;      // Safe area padding
  static const double edgeSpacingMobile = 16.0;    // Mobile edge spacing
  static const double edgeSpacingTablet = 32.0;    // Tablet edge spacing  
  static const double edgeSpacingDesktop = 48.0;   // Desktop edge spacing

  // GOLDEN RATIO INSPIRED SPACING
  /// For those special moments where mathematical beauty enhances editorial feel
  static const double goldenSection = 38.2;        // 1.618 * 24 (base spacing)
  static const double goldenMajor = 61.8;          // Φ * goldenSection
  static const double goldenMinor = 23.6;          // goldenSection / Φ
}

/// Responsive spacing helpers that adapt based on screen size
class EditorialResponsiveSpacing {
  /// Get appropriate edge spacing based on screen width
  static double edgeSpacing(double screenWidth) {
    if (screenWidth < EditorialSpacing.breakpointMobile) {
      return EditorialSpacing.edgeSpacingMobile;
    } else if (screenWidth < EditorialSpacing.breakpointTablet) {
      return EditorialSpacing.edgeSpacingMobile;
    } else if (screenWidth < EditorialSpacing.breakpointDesktop) {
      return EditorialSpacing.edgeSpacingTablet;
    } else {
      return EditorialSpacing.edgeSpacingDesktop;
    }
  }

  /// Get editorial asymmetric margins based on screen size
  static ({double left, double right}) editorialMargins(double screenWidth) {
    if (screenWidth < EditorialSpacing.breakpointTablet) {
      return (
        left: EditorialSpacing.editorialHeroLeftSmall,
        right: EditorialSpacing.editorialHeroRightSmall,
      );
    } else if (screenWidth < EditorialSpacing.breakpointDesktop) {
      return (
        left: EditorialSpacing.editorialHeroLeftMedium,
        right: EditorialSpacing.editorialHeroRightMedium,
      );
    } else {
      return (
        left: EditorialSpacing.editorialHeroLeftLarge,
        right: EditorialSpacing.editorialHeroRightLarge,
      );
    }
  }

  /// Get content max width that maintains editorial proportions
  static double contentMaxWidth(double screenWidth) {
    if (screenWidth < EditorialSpacing.breakpointDesktop) {
      return screenWidth * 0.92; // 8% margin total
    } else {
      return EditorialSpacing.editorialMainContentMax;
    }
  }
}