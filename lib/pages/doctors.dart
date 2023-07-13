import 'package:dental/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [DateTime.now()];
  String? lastPeriodStartDate = DateTime.now().toString().split(" ")[0];

  @override
  Widget build(BuildContext context) {
    // Build your UI components here
    return Scaffold(
      backgroundColor: dBackgroundColor,
      appBar: AppBar(
        title: const Text("Appointments"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: calendarWidget(),
          ),
        ]),
      ),
    );
  }

  Widget doctorCardWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
    
    );
  }

  Widget calendarWidget() {
    final CalendarDatePicker2Config config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: dPrimaryColor,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 0,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: dPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      //
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (List<DateTime?> values) => setState(() {
                  _singleDatePickerValueWithDefaultValue = values;
                  // lastPeriodStartDate =
                  //     _getValueText(config.calendarType, values);
                  // print("date $lastPeriodStartDate");
                  // values.toString();
                })
            // setState(() => ),

            ),
      ],
    );
  }

  // ignore: unused_element
  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values = values
        .map((DateTime? e) => e != null ? DateUtils.dateOnly(e) : null)
        .toList();
    String valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((DateTime? v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final String startDate =
            values[0].toString().replaceAll('00:00:00.000', '');
        final String endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
