import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color purple = Colors.purple;
  static const Color orange = Colors.orange;
  static const Color red = Colors.red;
  static const Color yellow = Colors.yellow;
  static const Color green = Colors.green;
  static const Color teal = Colors.teal;
  static const Color blue = Colors.blue;
  static const Color indigo = Colors.indigo;
  static const Color white70 = Colors.white70;

  // AppBar Colors
  static Color get appBarBlack => black.withValues(alpha: 0.9);
  static Color get appBarPurple => purple.withValues(alpha: 0.7);
  static Color get appBarTitleIconOrange => orange.withValues(alpha: 0.8);
  static Color get appBarTitleIconRed => red.withValues(alpha: 0.8);
  static Color get appBarShadow => black.withValues(alpha: 0.5);
  static Color get appBarTitleIconShadow => orange.withValues(alpha: 0.5);

  // Pop Counter Colors
  static Color get popCounterYellow => yellow.withValues(alpha: 0.9);
  static Color get popCounterOrange => orange.withValues(alpha: 0.9);
  static Color get popCounterBorder => white.withValues(alpha: 0.5);
  static Color get popCounterShadowYellow => yellow.withValues(alpha: 0.6);
  static Color get popCounterShadowBlack => black.withValues(alpha: 0.3);

  // Pause Button Colors
  static Color get pauseButtonGreen => green.withValues(alpha: 0.8);
  static Color get pauseButtonTeal => teal.withValues(alpha: 0.8);
  static Color get pauseButtonBlue => blue.withValues(alpha: 0.8);
  static Color get pauseButtonIndigo => indigo.withValues(alpha: 0.8);
  static Color pauseButtonShadow({required bool isPaused}) =>
      (isPaused ? green : blue).withValues(alpha: 0.5);

  // Splash Screen Colors
  static Color get splashPurple => purple.withValues(alpha: 0.8);
  static Color get splashIconOrange => orange.withValues(alpha: 0.9);
  static Color get splashIconRed => red.withValues(alpha: 0.9);
  static Color get splashIconShadow => orange.withValues(alpha: 0.6);
  static const Color splashLoadingIndicator = orange;

  // Game Overlay Colors
  static Color get overlayDialogPurple => purple.withValues(alpha: 0.85);
  static Color get overlayDialogIndigo => indigo.withValues(alpha: 0.85);
  static Color get overlayBorder => white.withValues(alpha: 0.3);
  static Color get overlayShadowBlack => black.withValues(alpha: 0.5);
  static Color get overlayShadowPurple => purple.withValues(alpha: 0.5);
  static Color get overlaySubtitle => white.withValues(alpha: 0.8);

  // Action Button Colors
  static Color get actionButtonPrimaryGreen => green.withValues(alpha: 0.9);
  static Color get actionButtonPrimaryTeal => teal.withValues(alpha: 0.9);
  static Color get actionButtonSecondaryOrange => orange.withValues(alpha: 0.9);
  static Color get actionButtonSecondaryRed => red.withValues(alpha: 0.9);
  static Color actionButtonShadow({required bool isPrimary}) =>
      (isPrimary ? green : orange).withValues(alpha: 0.6);
  static Color get actionButtonShadowBlack => black.withValues(alpha: 0.3);

  // Text Colors
  static const Color textWhite = white;
  static const Color textBlack = black;
  static Color get textSubtitle => white.withValues(alpha: 0.8);
  static const Color textWhite70 = white70;

  // Shadow Colors
  static const Color shadowPurple = purple;
  static const Color shadowOrange = orange;
  static Color get shadowBlack => black.withValues(alpha: 0.3);
  static Color get shadowBlackStrong => black.withValues(alpha: 0.5);

  // Private constructor to prevent instantiation
  AppColors._();
}
