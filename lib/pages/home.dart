import 'package:dental/data/data_provider.dart';
import 'package:dental/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../data/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    doctors = await getDoctors(lastPeriodStartDate);
  }

  Future<void> getDoctorsByDate() async {
    doctors = await getDoctors(lastPeriodStartDate);
  }

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [DateTime.now()];
  String? lastPeriodStartDate = DateTime.now().toString().split(" ")[0];
  List<Doctor> doctors = [];

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
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: calendarWidget(),
          ),
          const SizedBox(
            height: 20,
          ),
          (doctors.isNotEmpty)
              ? Column(
                  children: doctors.map((Doctor doctor) {
                  return doctorCard(doctor);
                }).toList())
              : const Text("Doctors available today will appear here"),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }

  Widget imageWidget(String url) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 130, 117, 246),
          borderRadius: BorderRadius.circular(30)),
      child: Image.network(
        url,
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget doctorCard(Doctor doctor) {
    return GestureDetector(
        onTap: (() {}),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageWidget(doctor.profilePicture),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Dr. ${doctor.user.firstName} ${doctor.user.middleName} ${doctor.user.lastName}',
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              )
            ],
          ),
        ));
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
        const Text(
          "Select Appointment Day",
          style: TextStyle(fontSize: 20),
        ),
        CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (List<DateTime?> values) => setState(() {
                  _singleDatePickerValueWithDefaultValue = values;
                  lastPeriodStartDate =
                      _getValueText(config.calendarType, values);
                    getDoctorsByDate();
                  // print("date $lastPeriodStartDate");
                  // values.toString();
                })
                
            // setState(() => ),

            ),
      ],
    );
  }

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
