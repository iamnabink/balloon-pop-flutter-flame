import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../utils/ui_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: UIUtils.splashBackground,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Icon/Logo
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: UIUtils.splashIcon,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.splashIconShadow,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.celebration,
                  size: 80,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 32),
              // App Title
              const Text(
                AppStrings.appName,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: AppColors.shadowPurple,
                      blurRadius: 15,
                      offset: Offset(0, 3),
                    ),
                    Shadow(
                      color: AppColors.shadowOrange,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.splashLoadingIndicator),
                strokeWidth: 4,
              ),
              const SizedBox(height: 24),
              const Text(
                AppStrings.loadingAssets,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textWhite70,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
