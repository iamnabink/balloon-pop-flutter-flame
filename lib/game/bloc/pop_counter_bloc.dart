// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

// Events
abstract class PopCounterEvent {}

class PopCounterIncremented extends PopCounterEvent {}

class PopCounterReset extends PopCounterEvent {}

class PopCounterDisplayCountUpdated extends PopCounterEvent {
  final int displayCount;
  PopCounterDisplayCountUpdated(this.displayCount);
}

class PopCounterScaleUpdated extends PopCounterEvent {
  final double scale;
  PopCounterScaleUpdated(this.scale);
}

class PopCounterAnimationStopped extends PopCounterEvent {}

// State
class PopCounterState {
  final int count;
  final int displayCount;
  final double scale;
  final bool isAnimating;

  PopCounterState({
    required this.count,
    required this.displayCount,
    required this.scale,
    required this.isAnimating,
  });

  PopCounterState copyWith({
    int? count,
    int? displayCount,
    double? scale,
    bool? isAnimating,
  }) {
    return PopCounterState(
      count: count ?? this.count,
      displayCount: displayCount ?? this.displayCount,
      scale: scale ?? this.scale,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}

// BLoC
class PopCounterBloc extends Bloc<PopCounterEvent, PopCounterState> {
  PopCounterBloc()
      : super(PopCounterState(
          count: 0,
          displayCount: 0,
          scale: 1.0,
          isAnimating: false,
        )) {
    on<PopCounterIncremented>(_onIncremented);
    on<PopCounterReset>(_onReset);
    on<PopCounterDisplayCountUpdated>(_onDisplayCountUpdated);
    on<PopCounterScaleUpdated>(_onScaleUpdated);
    on<PopCounterAnimationStopped>(_onAnimationStopped);
  }

  void _onIncremented(
    PopCounterIncremented event,
    Emitter<PopCounterState> emit,
  ) {
    emit(state.copyWith(
      count: state.count + 1,
      isAnimating: true,
      scale: 1.3,
    ));
  }

  void _onReset(
    PopCounterReset event,
    Emitter<PopCounterState> emit,
  ) {
    emit(PopCounterState(
      count: 0,
      displayCount: 0,
      scale: 1.0,
      isAnimating: false,
    ));
  }

  void _onDisplayCountUpdated(
    PopCounterDisplayCountUpdated event,
    Emitter<PopCounterState> emit,
  ) {
    emit(state.copyWith(displayCount: event.displayCount));
  }

  void _onScaleUpdated(
    PopCounterScaleUpdated event,
    Emitter<PopCounterState> emit,
  ) {
    emit(state.copyWith(scale: event.scale));
  }

  void _onAnimationStopped(
    PopCounterAnimationStopped event,
    Emitter<PopCounterState> emit,
  ) {
    emit(state.copyWith(
      isAnimating: false,
      scale: 1.0,
    ));
  }

  // Helper methods that dispatch events
  void updateDisplayCount(int displayCount) {
    add(PopCounterDisplayCountUpdated(displayCount));
  }

  void updateScale(double scale) {
    add(PopCounterScaleUpdated(scale));
  }

  void stopAnimating() {
    add(PopCounterAnimationStopped());
  }
}
