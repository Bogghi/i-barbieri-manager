class Slot {
  final String startTime;
  final String endTime;

  Slot({
    required this.startTime,
    required this.endTime
  });

  String getFormattedString() {
    return "$startTime - $endTime";
  }
}