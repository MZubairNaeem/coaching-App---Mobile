import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../utils/colors.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      weekFormat: true,
      daysTextStyle: TextStyle(
        color: AppColors().blackColor,
      ),
      weekendTextStyle: TextStyle(
        color: AppColors().blackColor,
      ),
      dayButtonColor: AppColors().whiteColor,
      todayButtonColor: AppColors().whiteColor,
      todayTextStyle: TextStyle(
        color: AppColors().primaryColor,
      ),
      selectedDayButtonColor: AppColors().whiteColor,
      selectedDayTextStyle: TextStyle(
        color: AppColors().primaryColor,
      ),
      headerTextStyle: TextStyle(
        color: AppColors().whiteColor,
        fontSize: 20.0,
      ),
      headerTitleTouchable: true,
      iconColor: AppColors().whiteColor,
      weekdayTextStyle: TextStyle(
        color: AppColors().whiteColor,
      ),
      dayPadding: 5.0,
    );
  }
}
