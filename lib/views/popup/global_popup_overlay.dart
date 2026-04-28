import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/popup_position.dart';
import 'package:venue_flow_app/providers/global_popup_state.dart';
import 'package:venue_flow_app/views/popup/popup_message_widget.dart';

class GlobalPopupOverlay extends ConsumerWidget {
  final Widget child;

  const GlobalPopupOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePopups = ref.watch(activePopupsProvider);
    final popupNotifier = ref.read(globalPopupProvider.notifier);

    return Stack(
      children: [
        // Main content
        child,

        // Popup overlay
        if (activePopups.isNotEmpty)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  // Glassy blurred background
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      color: Colors.white
                          .withOpacity(0.2), // semi-transparent overlay
                    ),
                  ),
                  ...activePopups.map((popup) {
                    return _buildPositionedPopup(popup, popupNotifier);
                  }).toList(),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPositionedPopup(
      PopupMessage popup, GlobalPopupNotifier notifier) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, viewport) {
          return Padding(
            padding: _paddingFor(popup.position),
            child: Align(
              alignment: _alignmentFor(popup.position),
              child: IntrinsicWidth(
                child: ConstrainedBox(
                  constraints: _constraintsFor(viewport, popup),
                  child: PopupMessageWidget(
                    popup: popup,
                    onDismiss: () => notifier.dismissPopup(popup.id),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Alignment _alignmentFor(PopupPosition position) {
    switch (position) {
      case PopupPosition.top:
        return Alignment.topCenter;
      case PopupPosition.center:
        return Alignment.center;
      case PopupPosition.bottom:
        return Alignment.bottomCenter;
      case PopupPosition.topLeft:
        return Alignment.topLeft;
      case PopupPosition.topRight:
        return Alignment.topRight;
      case PopupPosition.bottomLeft:
        return Alignment.bottomLeft;
      case PopupPosition.bottomRight:
        return Alignment.bottomRight;
    }
  }

  EdgeInsets _paddingFor(PopupPosition position) {
    switch (position) {
      case PopupPosition.top:
      case PopupPosition.topLeft:
      case PopupPosition.topRight:
        return const EdgeInsets.fromLTRB(16, 50, 16, 16);
      case PopupPosition.bottom:
      case PopupPosition.bottomLeft:
      case PopupPosition.bottomRight:
        return const EdgeInsets.fromLTRB(16, 16, 16, 50);
      case PopupPosition.center:
        return const EdgeInsets.all(16);
    }
  }

  BoxConstraints _constraintsFor(
    BoxConstraints viewport,
    PopupMessage popup,
  ) {
    final availableWidth = (viewport.maxWidth - 32).clamp(0.0, double.infinity);
    final minWidth =
        (popup.minWidth ?? 0.0).clamp(0.0, availableWidth).toDouble();
    final maxWidth =
        (popup.maxWidth ?? _defaultMaxWidth(viewport.maxWidth, popup.position))
            .clamp(minWidth, availableWidth)
            .toDouble();

    if (popup.width != null) {
      final width = popup.width!.clamp(minWidth, maxWidth).toDouble();
      return BoxConstraints.tightFor(width: width);
    }

    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
    );
  }

  double _defaultMaxWidth(double viewportWidth, PopupPosition position) {
    final maxByViewport =
        viewportWidth < 600 ? viewportWidth * 0.92 : viewportWidth * 0.6;

    switch (position) {
      case PopupPosition.topLeft:
      case PopupPosition.topRight:
      case PopupPosition.bottomLeft:
      case PopupPosition.bottomRight:
        return maxByViewport.clamp(220.0, 420.0).toDouble();
      case PopupPosition.top:
      case PopupPosition.bottom:
      case PopupPosition.center:
        return maxByViewport.clamp(260.0, 520.0).toDouble();
    }
  }
}
