
import 'package:flutter/cupertino.dart';

mixin InternalChecker {
  /// Map available to store times that can be used to control the frequency of any action.
  Map<String, IntervalTick>? _timers;

  /// Returns true if for each time the defined millisecond interval passes.
  /// Like a `Timer.periodic`
  /// Used in flows involved in the [update]
  bool checkInterval(
      String key,
      int intervalInMilli,
      double dt, {
        bool firstCheckIsTrue = true,
      }) {
    _timers ??= {};
    if (_timers![key]?.interval != intervalInMilli) {
      _timers![key] = IntervalTick(intervalInMilli);
      return firstCheckIsTrue;
    } else {
      return _timers![key]?.update(dt) ?? false;
    }
  }

  void resetInterval(String key) {
    _timers?[key]?.reset();
  }

  void tickInterval(String key) {
    _timers?[key]?.tick();
  }

  void pauseEffectController(String key) {
    _timers?[key]?.pause();
  }

  void playInterval(String key) {
    _timers?[key]?.play();
  }

  bool invervalIsRunning(String key) {
    return _timers?[key]?.running ?? false;
  }
}


class IntervalTick {
  late int interval; // in Milliseconds
  final VoidCallback? onTick;
  double _currentTime = 0;
  bool _running = true;
  late double _intervalSeconds;
  IntervalTick(this.interval, {this.onTick}) {
    _intervalSeconds = interval / 1000;
  }

  bool update(double dt) {
    if (_running) {
      _currentTime += dt;
      if (_currentTime >= _intervalSeconds) {
        onTick?.call();
        reset();
        return true;
      }
    }

    return false;
  }

  void reset() {
    _currentTime = 0;
  }

  void pause() {
    _running = false;
  }

  void play() {
    _running = true;
  }

  void tick() {
    _currentTime = _intervalSeconds;
  }

  bool get running => _running;
}