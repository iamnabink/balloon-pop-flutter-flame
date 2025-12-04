import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/ui_utils.dart';

class FancyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int counter;
  final bool isPaused;
  final bool isGameStarted;
  final VoidCallback onPauseToggle;

  const FancyAppBar({
    super.key,
    required this.title,
    required this.counter,
    required this.isPaused,
    required this.isGameStarted,
    required this.onPauseToggle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: UIUtils.appBarBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.appBarShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Title with fancy styling
              _buildTitle(),
              // Right side: Counter and Pause button
              Row(
                children: [
                  _buildPopCounter(),
                  const SizedBox(width: 12),
                  _buildPauseButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: UIUtils.appBarTitleIcon,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.appBarTitleIconShadow,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.celebration,
            color: AppColors.textWhite,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textWhite,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: AppColors.shadowPurple,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
              Shadow(
                color: AppColors.shadowOrange,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: UIUtils.popCounter,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.popCounterBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.popCounterShadowYellow,
            blurRadius: 12,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.popCounterShadowBlack,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.celebration,
            color: AppColors.textWhite,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '$counter',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
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
    );
  }

  Widget _buildPauseButton() {
    final isEnabled = isGameStarted;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Container(
        decoration: BoxDecoration(
          gradient: UIUtils.pauseButton(isPaused: isPaused),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.pauseButtonShadow(isPaused: isPaused),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? onPauseToggle : null,
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.settings,
                // isPaused ? Icons.play_arrow : Icons.pause,
                color: AppColors.textWhite,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
