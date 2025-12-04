import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../utils/ui_utils.dart';

enum OverlayAction {
  start,
  pause,
  resume,
  restart,
  options,
  exit,
}

class GameOverlay extends StatelessWidget {
  final OverlayAction action;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final String? subtitle;

  const GameOverlay({
    super.key,
    required this.action,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.subtitle,
  });

  String get _title {
    switch (action) {
      case OverlayAction.start:
        return AppStrings.readyToPlay;
      case OverlayAction.pause:
        return AppStrings.paused;
      case OverlayAction.resume:
        return AppStrings.gamePaused;
      case OverlayAction.restart:
        return AppStrings.restartGame;
      case OverlayAction.options:
        return AppStrings.options;
      case OverlayAction.exit:
        return AppStrings.exitGame;
    }
  }

  IconData get _icon {
    switch (action) {
      case OverlayAction.start:
        return Icons.play_circle_filled;
      case OverlayAction.pause:
        return Icons.pause_circle_filled;
      case OverlayAction.resume:
        return Icons.play_circle_filled;
      case OverlayAction.restart:
        return Icons.refresh;
      case OverlayAction.options:
        return Icons.settings;
      case OverlayAction.exit:
        return Icons.exit_to_app;
    }
  }

  String get _primaryButtonText {
    switch (action) {
      case OverlayAction.start:
        return AppStrings.start;
      case OverlayAction.pause:
        return AppStrings.resume;
      case OverlayAction.resume:
        return AppStrings.resume;
      case OverlayAction.restart:
        return AppStrings.restart;
      case OverlayAction.options:
        return AppStrings.close;
      case OverlayAction.exit:
        return AppStrings.exit;
    }
  }

  IconData get _primaryButtonIcon {
    switch (action) {
      case OverlayAction.start:
      case OverlayAction.resume:
        return Icons.play_arrow;
      case OverlayAction.pause:
        return Icons.play_arrow;
      case OverlayAction.restart:
        return Icons.refresh;
      case OverlayAction.options:
        return Icons.close;
      case OverlayAction.exit:
        return Icons.exit_to_app;
    }
  }

  String? get _secondaryButtonText {
    switch (action) {
      case OverlayAction.pause:
      case OverlayAction.resume:
        return AppStrings.restart;
      case OverlayAction.restart:
        return AppStrings.cancel;
      case OverlayAction.options:
        return AppStrings.exit;
      case OverlayAction.start:
      case OverlayAction.exit:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 400,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          gradient: UIUtils.overlayDialog,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.overlayBorder,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.overlayShadowBlack,
              blurRadius: 20,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: AppColors.overlayShadowPurple,
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon,
              size: 64,
              color: AppColors.textWhite,
            ),
            const SizedBox(height: 16),
            Text(
              _title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    color: AppColors.textBlack,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            // Always show subtitle area for consistent sizing
            const SizedBox(height: 8),
            SizedBox(
              height: 20, // Fixed height for subtitle area
              child: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.overlaySubtitle,
                        letterSpacing: 1,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            // Action buttons - fixed height to ensure consistent dialog size
            SizedBox(
              height: _getButtonAreaHeight(),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Primary action button
                    if (onPrimaryAction != null)
                      _buildActionButton(
                        text: _primaryButtonText,
                        icon: _primaryButtonIcon,
                        onTap: onPrimaryAction!,
                        isPrimary: true,
                      ),
                    // Secondary action button (if exists)
                    if (_secondaryButtonText != null &&
                        onSecondaryAction != null) ...[
                      const SizedBox(height: 12),
                      _buildActionButton(
                        text: _secondaryButtonText!,
                        icon: _getSecondaryIcon(),
                        onTap: onSecondaryAction!,
                        isPrimary: false,
                      ),
                    ],
                    // Placeholder for start overlay to match pause overlay height
                    if (_secondaryButtonText == null &&
                        action == OverlayAction.start) ...[
                      const SizedBox(height: 12),
                      Opacity(
                        opacity: 0.0,
                        child: _buildActionButton(
                          text: AppStrings.restart,
                          icon: Icons.refresh,
                          onTap: () {},
                          isPrimary: false,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSecondaryIcon() {
    switch (action) {
      case OverlayAction.pause:
      case OverlayAction.resume:
        return Icons.refresh;
      case OverlayAction.restart:
        return Icons.close;
      case OverlayAction.options:
        return Icons.exit_to_app;
      default:
        return Icons.close;
    }
  }

  double _getButtonAreaHeight() {
    // Calculate height based on whether secondary button exists
    // Button height: ~60px (padding 16*2 + text/icon ~28px)
    // Spacing: 12px
    // Added extra 4px padding to prevent overflow
    if (_secondaryButtonText != null && onSecondaryAction != null) {
      return 136.0; // Two buttons + spacing + padding
    } else if (action == OverlayAction.start) {
      return 136.0; // One button + invisible placeholder + padding
    } else {
      return 64.0; // Single button + padding
    }
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: UIUtils.actionButton(isPrimary: isPrimary),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.actionButtonShadow(isPrimary: isPrimary),
            blurRadius: 12,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.actionButtonShadowBlack,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: AppColors.textWhite,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: AppColors.textBlack,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
