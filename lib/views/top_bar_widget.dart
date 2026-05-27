import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/providers/auth_provider.dart';
import 'package:venue_flow_app/routing/app_routes.dart';
import 'package:venue_flow_app/theme/editorial_theme_data.dart';
import 'package:venue_flow_app/theme/spacing.dart';

class TopBarWidget extends ConsumerStatefulWidget {
  const TopBarWidget({super.key});

  @override
  ConsumerState<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends ConsumerState<TopBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    final isLoggedIn = ref.watch(isAuthenticatedProvider);
    UserModel? currentUser = ref.watch(currentUserProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTabletOrSmaller =
            constraints.maxWidth < EditorialSpacing.breakpointDesktop;
        final isMobile =
            constraints.maxWidth < EditorialSpacing.breakpointTablet;

        return Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: EditorialSpacing.spacing6),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (!isMobile)
                Flexible(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search events, forms, or clients...',
                            hintStyle: editorial.captionStyle,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: EditorialSpacing.spacing4,
                              vertical: EditorialSpacing.spacing2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isMobile) const SizedBox(width: EditorialSpacing.spacing4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isLoggedIn) ...[
                      const SizedBox(width: EditorialSpacing.spacing2),
                      if (!isTabletOrSmaller)
                        Container(
                          width: 1,
                          height: 32,
                          color: colorScheme.outline.withOpacity(0.2),
                        ),
                      if (!isTabletOrSmaller)
                        const SizedBox(width: EditorialSpacing.spacing4),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.primary.withOpacity(0.1),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: EditorialSpacing.spacing2),
                          PopupMenuButton(
                            offset: const Offset(0, 50),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: const Text('Logout'),
                                  onTap: () {
                                    ref.read(authRepositoryProvider).signOut();
                                    context.goNamed(AppRouteNames.login);
                                  },
                                ),
                              ];
                            },
                            child: isTabletOrSmaller
                                ? const Icon(Icons.expand_more)
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentUser?.fullName ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        currentUser?.role?.name.toUpperCase() ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
