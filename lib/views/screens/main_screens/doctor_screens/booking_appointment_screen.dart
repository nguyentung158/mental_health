import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/schedule_controller.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class BookingAppointmentScreen extends StatefulWidget {
  final String docId;
  final String title;
  final String subTitle;

  const BookingAppointmentScreen(
      {super.key,
      required this.docId,
      required this.title,
      required this.subTitle});

  @override
  _BookingAppointmentScreenState createState() =>
      _BookingAppointmentScreenState();
}

class _BookingAppointmentScreenState extends State<BookingAppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:00 AM';

  List<String> availableTimes = [
    '9:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00',
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
  ];

  int selectedIndex = -1;

  String formatDate(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();

    if (day.length < 2) {
      day = '0$day';
    }
    if (month.length < 2) {
      month = '0$month';
    }
    String date = '$year-$month-$day';
    return date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          const Icon(Icons.calendar_today),
          const SizedBox(width: 8),
          Text(
            formatDate(selectedDate),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDropdown() {
    return FutureBuilder<List<String>>(
        future: Provider.of<ScheduleController>(context, listen: false)
            .getAvailableTime(widget.docId, formatDate(selectedDate)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          availableTimes = snapshot.data!;
          return Consumer<ScheduleController>(
            builder: (context, value, child) {
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(0),
                  children: List.generate(availableTimes.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex = Provider.of<ScheduleController>(context,
                                listen: false)
                            .selectCard(index);
                      },
                      child: Card(
                        color: value.selectedIndex == index
                            ? Colors.blue
                            : Colors.white,
                        child: Center(
                          child: Text(
                            availableTimes[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: value.selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDatePicker(),
            const SizedBox(height: 16),
            const Text(
              'Select an available time:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildTimeDropdown(),
            const SizedBox(height: 16),
            Consumer<ScheduleController>(
              builder: (context, value, child) => InkWell(
                onTap: () async {
                  await value.bookAppointment(
                      formatDate(selectedDate),
                      availableTimes[selectedIndex],
                      widget.title,
                      widget.subTitle,
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.docId);
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.bottomSlide,
                          title: 'Congratulation!',
                          desc: 'Your request has been sent to the doctor.',
                          dismissOnTouchOutside: false,
                          btnOkOnPress: (() async {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }),
                          dismissOnBackKeyPress: false)
                      .show();
                },
                child: value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AuthButton(
                        title: 'Book Appointment',
                        color: Colors.white,
                        backGroundColor: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
