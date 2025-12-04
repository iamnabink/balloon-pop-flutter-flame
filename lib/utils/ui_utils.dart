import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class UIUtils {
  // AppBar Gradients
  static LinearGradient get appBarBackground => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.appBarBlack,
          AppColors.appBarPurple,
          AppColors.appBarBlack,
        ],
      );

  static LinearGradient get appBarTitleIcon => LinearGradient(
        colors: [
          AppColors.appBarTitleIconOrange,
          AppColors.appBarTitleIconRed,
        ],
      );

  static LinearGradient get popCounter => LinearGradient(
        colors: [
          AppColors.popCounterYellow,
          AppColors.popCounterOrange,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient pauseButton({required bool isPaused}) => LinearGradient(
        colors: isPaused
            ? [
                AppColors.pauseButtonGreen,
                AppColors.pauseButtonTeal,
              ]
            : [
                AppColors.pauseButtonBlue,
                AppColors.pauseButtonIndigo,
              ],
      );

  // Splash Screen Gradients
  static LinearGradient get splashBackground => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.black,
          AppColors.splashPurple,
          AppColors.black,
        ],
      );

  static LinearGradient get splashIcon => LinearGradient(
        colors: [
          AppColors.splashIconOrange,
          AppColors.splashIconRed,
        ],
      );

  // Game Overlay Gradients
  static LinearGradient get overlayDialog => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.overlayDialogPurple,
          AppColors.overlayDialogIndigo,
        ],
      );

  static LinearGradient actionButton({required bool isPrimary}) =>
      LinearGradient(
        colors: isPrimary
            ? [
                AppColors.actionButtonPrimaryGreen,
                AppColors.actionButtonPrimaryTeal,
              ]
            : [
                AppColors.actionButtonSecondaryOrange,
                AppColors.actionButtonSecondaryRed,
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // Private constructor to prevent instantiation
  UIUtils._();
}
