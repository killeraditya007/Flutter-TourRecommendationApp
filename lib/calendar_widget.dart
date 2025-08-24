import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TourCalendarWidget extends StatefulWidget {
  final int tourDays;
  const TourCalendarWidget({Key? key, this.tourDays = 5}) : super(key: key);

  @override
  _TourCalendarWidgetState createState() => _TourCalendarWidgetState();
}

class _TourCalendarWidgetState extends State<TourCalendarWidget> {
  DateTime? _selectedDate;
  List<DateTime> _highlightedDates = [];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      DateTime startDate = args.value;
      List<DateTime> tourDates = [];

      for (int i = 0; i < widget.tourDays; i++) {
        tourDates.add(startDate.add(Duration(days: i)));
      }

      setState(() {
        _selectedDate = startDate;
        _highlightedDates = tourDates;
        print(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      showActionButtons: true,
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      initialSelectedDate: DateTime.now(),
      minDate: DateTime.now(), // disable past dates
      maxDate: DateTime.now().add(Duration(days: 60)), // only 2 months ahead
      monthViewSettings: DateRangePickerMonthViewSettings(
        blackoutDates: [], // you can mark booked dates here later
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        blackoutDateTextStyle: TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough),
        weekendTextStyle: TextStyle(color: Colors.black),
        todayTextStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      cellBuilder: (context, details) {
        bool isHighlighted = _highlightedDates.any((d) =>
            d.year == details.date.year &&
            d.month == details.date.month &&
            d.day == details.date.day);

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            details.date.day.toString(),
            style: TextStyle(
              color: details.date.isBefore(DateTime.now())
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
