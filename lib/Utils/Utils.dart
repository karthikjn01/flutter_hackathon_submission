class Utils {
  static String calculateTime(Duration timer) {
    var minsLeft = timer.inMinutes % 60;
    var hoursLeft = (timer.inMinutes / 60).floor();
    var secondsLeft = (timer.inSeconds) % 60;
    return "$hoursLeft ${hoursLeft != 1 ? "hours" : "hour"} $minsLeft ${minsLeft != 1 ? "mins" : "min"} $secondsLeft ${secondsLeft != 1 ? "secs" : "sec"}";
  }
}
