
import 'dart:developer';

class Validation {
  static double getPercentValueInt(int total, int value) {
    return value / total > 0 ? value / total : 0;
  }

  static double getPercentValueDate(DateTime? lastDate, DateTime? nextDate) {
    DateTime last = lastDate ?? DateTime.now();
    DateTime next = nextDate ?? DateTime.now();
    int totalDays = next.difference(last).inDays;
    int elapsedDays = last.difference(DateTime.now()).inDays;

    totalDays = totalDays >= 0 ? totalDays : totalDays * -1;
    elapsedDays = elapsedDays >= 0 ? elapsedDays : elapsedDays * -1;

    return getPercentValueInt(totalDays, elapsedDays);
  }

  static List<DateTime> validateNextDate(
      int vehicleYear, int days, DateTime? lastDate) {

    List<DateTime> result = List.empty(growable: true);
    DateTime nextDate;

    if (lastDate != null) {
      nextDate = lastDate.add(Duration(days: days));
    } else {
      lastDate = DateTime(vehicleYear);
      nextDate = lastDate.add(Duration(days: days));
    }

    result.add(lastDate);
    result.add(nextDate);
    return result;
  }

  static List<int> validateNextKm(int vehicleOdometer, int km, int lastKm) {

    List<int> result = List.empty(growable: true);
    int nextKm;

    if (lastKm > 0) {
      nextKm = lastKm + km;
    } else {
      lastKm = vehicleOdometer;
      nextKm = vehicleOdometer + km;
    }

    result.add(lastKm);
    result.add(nextKm);
    return result;    
  }
}
