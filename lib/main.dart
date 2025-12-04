import 'package:flutter/material.dart';
import 'package:flame/game.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/app_strings.dart';
import 'constants/app_assets.dart';
import 'game/balloon_game.dart';
import 'game/bloc/pop_counter_bloc.dart';
import 'widgets/fancy_app_bar.dart';
import 'widgets/game_overlay.dart';
import 'widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create PopCounterBloc at app level
  final popCounterBloc = PopCounterBloc();
  int _gameKey = 0;

  void _restartGame() {
    // Reset counter
    popCounterBloc.add(PopCounterReset());
    // Change key to force complete rebuild
    setState(() {
      _gameKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PopCounterBloc>.value(
      value: popCounterBloc,
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: GameScreen(
          key: ValueKey(_gameKey),
          popCounterBloc: popCounterBloc,
          onRestart: _restartGame,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final PopCounterBloc popCounterBloc;
  final VoidCallback? onRestart;

  const GameScreen({
    super.key,
    required this.popCounterBloc,
    this.onRestart,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late BalloonGame game;
  bool isPaused = false;
  bool isLoading = true;
  bool showStartOverlay = false;

  @override
  void initState() {
    super.initState();
    game = BalloonGame(
      popCounterBloc: widget.popCounterBloc,
      onLoaded: () {
        if (mounted) {
          setState(() {
            isLoading = false;
            showStartOverlay = true;
          });
        }
      },
    );
  }

  void startGame() {
    setState(() {
      showStartOverlay = false;
    });
    game.startGame();
  }

  void restartGame() {
    // Call parent's restart to rebuild with new key
    widget.onRestart?.call();
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        game.pauseEngine();
      } else {
        game.resumeEngine();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopCounterBloc, PopCounterState>(
      bloc: widget.popCounterBloc,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: isLoading
              ? null
              : FancyAppBar(
                  title: AppStrings.appName,
                  counter: state.count,
                  isPaused: isPaused,
                  isGameStarted: game.isStarted,
                  onPauseToggle: togglePause,
                ),
          body: SafeArea(
            child: Stack(
              children: [
                // Always render game widget so onLoad gets called
                GameWidget<BalloonGame>.controlled(gameFactory: () => game),
                // Splash screen overlay during loading
                if (isLoading) const SplashScreen(),
                // Unified game overlay - for start or pause
                if (showStartOverlay)
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: GameOverlay(
                      action: OverlayAction.start,
                      onPrimaryAction: startGame,
                      subtitle: AppStrings.tapBalloonsSubtitle,
                    ),
                  ),
                if (isPaused && !showStartOverlay)
                  GameOverlay(
                    action: OverlayAction.resume,
                    onPrimaryAction: togglePause,
                    onSecondaryAction: restartGame,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
