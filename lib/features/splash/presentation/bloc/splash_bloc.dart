import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinksy_ai/features/splash/presentation/bloc/splash_event.dart';
import 'package:thinksy_ai/features/splash/presentation/bloc/splash_state.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final Duration duration;

  SplashBloc({this.duration = const Duration(milliseconds: 2400)})
      : super(const SplashState()) {
    on<SplashStarted>(onSplashStarted);
  }

  Future<void> onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    await Future<void>.delayed(duration);
    emit(const SplashState(isCompleted: true));
  }
}