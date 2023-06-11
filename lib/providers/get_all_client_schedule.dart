import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Schedule.dart';
import '../viewmodels/scheduleViewModel.dart';

final scheduleProvider = StreamProvider<List<Schedule>>((ref) {
  try {
    final stream = SchduleViewModel().getAllSchedules();
    return stream;
  } catch (e) {
    return Stream.value([]);
  }
});
