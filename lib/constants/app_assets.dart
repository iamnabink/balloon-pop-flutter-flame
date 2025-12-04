class AppAssets {
  // Image Paths
  static const String imagesPath = 'assets/images/';
  static const String backgroundImage = '${imagesPath}background.png';

  // Image Names (for Flame cache)
  static const String backgroundImageName = 'background.png';
  static const String redBalloon = 'red.png';

  // Audio Paths
  static const String audioPath = 'assets/audio/';
  static const String balloonBurstSound = '${audioPath}balloon-burst.mp3';

  // Audio Names (for Flame cache)
  static const String balloonBurstSoundName = 'balloon-burst.mp3';

  // Sprite Sheet Names
  static String getSpriteSheetName(String colorName) {
    return '${colorName}SpriteSheetAnimation.png';
  }

  // Balloon Image Name
  static String getBalloonImageName(String color) {
    return '$color.png';
  }

  // Private constructor to prevent instantiation
  AppAssets._();
}
