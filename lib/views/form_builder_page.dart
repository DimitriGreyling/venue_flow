import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/editorial_theme_data.dart';
import '../theme/spacing.dart';

class FormBuilderPage extends ConsumerStatefulWidget {
  const FormBuilderPage({super.key});

  @override
  ConsumerState<FormBuilderPage> createState() => _FormBuilderPageState();
}

class _FormBuilderPageState extends ConsumerState<FormBuilderPage> {
  String selectedFieldType = 'Text Input';
  bool isFieldSelected = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final editorial = context.editorial;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: _buildAppBar(context, colorScheme, textTheme),
      body: Row(
        children: [
          // Left Sidebar - Form Elements
          _buildComponentSidebar(context, colorScheme, editorial),
          
          // Center Canvas - Form Builder
          Expanded(
            child: _buildFormCanvas(context, colorScheme, textTheme, editorial),
          ),
          
          // Right Sidebar - Properties Panel
          _buildPropertiesPanel(context, colorScheme, textTheme, editorial),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      title: Row(
        children: [
          Text(
            'Venue Flow',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 48),
          _buildNavigation(context, colorScheme),
        ],
      ),
      actions: [
        _buildHeaderActions(context, colorScheme),
      ],
    );
  }

  Widget _buildNavigation(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        _buildNavItem('Dashboard', false, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Forms', true, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Events', false, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Settings', false, colorScheme),
      ],
    );
  }

  Widget _buildNavItem(String title, bool isActive, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
        if (isActive) 
          Container(
            height: 2,
            width: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined, color: colorScheme.onSurfaceVariant),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.outlineVariant,
          child: Icon(Icons.person, size: 18, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildComponentSidebar(BuildContext context, ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      width: 288,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FORM ELEMENTS',
              style: editorial.labelUppercase.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  _buildFormElements(colorScheme, editorial),
                  const SizedBox(height: 32),
                  Text(
                    'ADVANCED',
                    style: editorial.labelUppercase.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildAdvancedElements(colorScheme, editorial),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormElements(ColorScheme colorScheme, EditorialThemeData editorial) {
    final elements = [
      {'icon': Icons.short_text, 'title': 'Text Input'},
      {'icon': Icons.list, 'title': 'Select Menu'},
      {'icon': Icons.check_box_outlined, 'title': 'Checkbox Group'},
      {'icon': Icons.calendar_month, 'title': 'Date Picker'},
      {'icon': Icons.upload_file, 'title': 'File Upload'},
    ];

    return Column(
      children: elements.map((element) => 
        _buildDraggableElement(
          element['icon'] as IconData,
          element['title'] as String,
          colorScheme.secondary,
          colorScheme,
          editorial,
        ),
      ).toList(),
    );
  }

  Widget _buildAdvancedElements(ColorScheme colorScheme, EditorialThemeData editorial) {
    final elements = [
      {'icon': Icons.draw, 'title': 'E-Signature'},
      {'icon': Icons.payments, 'title': 'Payment Link'},
    ];

    return Column(
      children: elements.map((element) => 
        _buildDraggableElement(
          element['icon'] as IconData,
          element['title'] as String,
          colorScheme.tertiary,
          colorScheme,
          editorial,
        ),
      ).toList(),
    );
  }

  Widget _buildDraggableElement(
    IconData icon,
    String title,
    Color iconColor,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedFieldType = title;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: editorial.navigationLabel.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCanvas(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, EditorialThemeData editorial) {
    return Container(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INTAKE DESIGNER',
                      style: editorial.labelUppercase.copyWith(
                        color: colorScheme.secondary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'VIP Wedding Package Form',
                      style: textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildActionButton('Preview', false, colorScheme, editorial),
                    const SizedBox(width: 12),
                    _buildActionButton('Save Draft', false, colorScheme, editorial),
                    const SizedBox(width: 12),
                    _buildActionButton('Publish Form', true, colorScheme, editorial),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Canvas Area
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  children: [
                    _buildSectionHeader(colorScheme, textTheme, editorial),
                    const SizedBox(height: 24),
                    _buildSelectedField(colorScheme, textTheme, editorial),
                    const SizedBox(height: 24),
                    _buildFormField('Preferred Wedding Date', 'Select Date...', Icons.calendar_today, false, colorScheme, textTheme, editorial),
                    const SizedBox(height: 24),
                    _buildDropZone(colorScheme, editorial),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, bool isPrimary, ColorScheme colorScheme, EditorialThemeData editorial) {
    return MaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(
        horizontal: isPrimary ? 24 : 20,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: isPrimary 
          ? colorScheme.primaryContainer 
          : colorScheme.surfaceContainerLowest,
      elevation: isPrimary ? 2 : 0,
      child: Text(
        text,
        style: editorial.buttonTextStyle.copyWith(
          color: isPrimary 
              ? colorScheme.onPrimary 
              : colorScheme.onSurfaceVariant,
          fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ColorScheme colorScheme, TextTheme textTheme, EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Essentials',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Basic information regarding the requested venue date and party size.',
                style: editorial.captionStyle.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Icon(Icons.drag_indicator, color: colorScheme.outline),
        ],
      ),
    );
  }

  Widget _buildSelectedField(ColorScheme colorScheme, TextTheme textTheme, EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Selected Badge
          Positioned(
            top: -48,
            left: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SELECTED',
                style: editorial.labelUppercase.copyWith(
                  color: colorScheme.onSecondary,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Full Name of Primary Contact',
                    style: editorial.labelBold.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.content_copy, size: 18),
                        color: colorScheme.outline,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline, size: 18),
                        color: colorScheme.error,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'e.g. Johnathan Smith',
                    style: editorial.placeholderStyle.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String placeholder,
    IconData? trailingIcon,
    bool isSelected,
    ColorScheme colorScheme,
    TextTheme textTheme,
    EditorialThemeData editorial,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? colorScheme.secondary : Colors.transparent,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: editorial.labelBold.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(Icons.drag_indicator, color: colorScheme.outlineVariant),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  placeholder,
                  style: editorial.placeholderStyle.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (trailingIcon != null)
                  Icon(trailingIcon, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropZone(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 2,
          style: BorderStyle.solid,
        ),
        color: colorScheme.surfaceContainerLow,
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainer,
            ),
            child: Icon(
              Icons.add,
              color: colorScheme.outline,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Drag a component here or click to add a field',
            style: editorial.labelSubtle.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesPanel(BuildContext context, ColorScheme colorScheme, TextTheme textTheme, EditorialThemeData editorial) {
    return Container(
      width: 320,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, size: 16, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  'FIELD PROPERTIES',
                  style: editorial.labelUppercase.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPropertyField(
                    'Label',
                    'Full Name of Primary Contact',
                    colorScheme,
                    editorial,
                  ),
                  const SizedBox(height: 24),
                  _buildPropertyField(
                    'Placeholder Text',
                    'e.g. Johnathan Smith',
                    colorScheme,
                    editorial,
                  ),
                  const SizedBox(height: 32),
                  
                  // Validation Toggles
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outlineVariant.withOpacity(0.3),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        _buildToggleOption('Required Field', true, colorScheme, editorial),
                        const SizedBox(height: 16),
                        _buildToggleOption('Unique Answer', false, colorScheme, editorial),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Conditional Logic
                  Text(
                    'CONDITIONAL LOGIC',
                    style: editorial.labelUppercase.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAddRuleButton(colorScheme, editorial),
                  
                  const SizedBox(height: 32),
                  
                  // Helper Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.tertiary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Helper Text',
                                style: editorial.labelBold.copyWith(
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Provide context to your guests for why this field is required.',
                                style: editorial.captionStyle.copyWith(
                                  fontSize: 10,
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyField(
    String label,
    String value,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: editorial.labelBold.copyWith(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.secondary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(12),
            hintText: value,
          ),
          style: editorial.formFieldStyle,
        ),
      ],
    );
  }

  Widget _buildToggleOption(
    String title,
    bool value,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: editorial.labelSubtle.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Toggle functionality
          },
          child: Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: value ? colorScheme.primaryContainer : colorScheme.outlineVariant,
            ),
            child: AnimatedAlign(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddRuleButton(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          '+ Add Display Rule',
          style: editorial.labelBold.copyWith(
            fontSize: 12,
            color: colorScheme.outline,
          ),
        ),
      ),
    );
  }
}