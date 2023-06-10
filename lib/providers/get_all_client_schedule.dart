import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Schedule.dart';
import '../viewmodels/scheduleViewModel.dart';

final scheduleProvider = FutureProvider<List<Schedule>>((ref) async {
  try {
    List<Schedule> schedules = await SchduleViewModel().getAllSchedules();
    return schedules;
  } catch (e) {
    return [];
  }
});
