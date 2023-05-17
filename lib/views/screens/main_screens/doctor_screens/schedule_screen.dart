// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/controllers/account_controller.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/controllers/schedule_controller.dart';
import 'package:mental_health_app/models/appointment.dart';
import 'package:mental_health_app/models/doctor.dart';
import 'package:mental_health_app/models/user.dart';
import 'package:mental_health_app/schedule_styles/colors.dart';
import 'package:mental_health_app/schedule_styles/styles.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/booking_appointment_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/review_doctor_screen.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

enum FilterStatus { Upcoming, Complete, Cancel, Pending }

class _ScheduleScreenState extends State<ScheduleScreen> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Appointment> filteredSchedules = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Schedule',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: !User.isDoctor
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MyColors.bg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Upcoming) {
                                  status = FilterStatus.Upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
                                  _alignment = const Alignment(-0.3, 0);
                                } else if (filterStatus ==
                                    FilterStatus.Cancel) {
                                  status = FilterStatus.Cancel;
                                  _alignment = const Alignment(0.35, 0);
                                } else if (filterStatus ==
                                    FilterStatus.Pending) {
                                  status = FilterStatus.Pending;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) / 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<ScheduleController>(
                builder: (context, value, child) {
                  if (status == FilterStatus.Upcoming) {
                    filteredSchedules = value.upcomingAppointments;
                  } else if (status == FilterStatus.Pending) {
                    filteredSchedules = value.pendingAppointments;
                  } else if (status == FilterStatus.Complete) {
                    filteredSchedules = value.completedAppointments;
                  } else if (status == FilterStatus.Cancel) {
                    filteredSchedules = value.canceledAppointments;
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await value.fetchAndSetData();
                    },
                    child: ListView.builder(
                      itemCount: filteredSchedules.length,
                      itemBuilder: (context, index) {
                        var schedule = filteredSchedules[index];
                        bool isLastElement =
                            filteredSchedules.length + 1 == index;
                        return !User.isDoctor
                            ? FutureBuilder<DoctorModel>(
                                future: Provider.of<DoctorController>(context,
                                        listen: false)
                                    .getDoctorInfo(schedule.docId!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center();
                                  }
                                  return Card(
                                    margin: !isLastElement
                                        ? const EdgeInsets.only(bottom: 20)
                                        : EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot.data!.image),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.name,
                                                    style: TextStyle(
                                                      color: Color(
                                                          MyColors.header01),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data!.type,
                                                    style: TextStyle(
                                                      color: Color(
                                                          MyColors.grey02),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          DateTimeCard(
                                              date: schedule.date!,
                                              time: schedule.time!),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FilterButton(
                                            status: status,
                                            doctor: snapshot.data!,
                                            appointmentId: schedule.id!,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : FutureBuilder<User>(
                                future: Provider.of<AccountController>(context,
                                        listen: false)
                                    .getUserInfo(schedule.userId!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center();
                                  }
                                  return Card(
                                    margin: !isLastElement
                                        ? const EdgeInsets.only(bottom: 20)
                                        : EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data!.profilePhoto),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.name,
                                                    style: TextStyle(
                                                      color: Color(
                                                          MyColors.header01),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data!.gender,
                                                    style: TextStyle(
                                                      color: Color(
                                                          MyColors.grey02),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          DateTimeCard(
                                              date: schedule.date!,
                                              time: schedule.time!),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FilterDoctorButton(
                                            status: status,
                                            user: snapshot.data!,
                                            appointmentId: schedule.id!,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final FilterStatus status;
  final DoctorModel doctor;
  final String appointmentId;
  const FilterButton({
    Key? key,
    required this.status,
    required this.doctor,
    required this.appointmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (status == FilterStatus.Complete)
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius
                ),
              ),
              child: const Text('Review'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReviewDoctorScreen(docId: doctor.uid),
                ));
              },
            ),
          ),
        if (status != FilterStatus.Complete && status != FilterStatus.Cancel)
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () async {
                await Provider.of<ScheduleController>(context, listen: false)
                    .cancelAppointment(
                        appointmentId,
                        status == FilterStatus.Pending
                            ? 'pending'
                            : 'confirmed');
              },
            ),
          ),
        if (status == FilterStatus.Complete)
          const SizedBox(
            width: 20,
          ),
        if (status != FilterStatus.Upcoming && status != FilterStatus.Pending)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Set the border radius
                  ),
                  backgroundColor: const Color.fromRGBO(71, 206, 254, 1)),
              child: const Text('Reschedule'),
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookingAppointmentScreen(
                      docId: doctor.uid,
                      title: doctor.name,
                      subTitle: doctor.type),
                ))
              },
            ),
          )
      ],
    );
  }
}

class FilterDoctorButton extends StatelessWidget {
  final FilterStatus status;
  final User user;
  final String appointmentId;
  const FilterDoctorButton({
    Key? key,
    required this.status,
    required this.user,
    required this.appointmentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (status != FilterStatus.Complete && status != FilterStatus.Cancel)
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () async {
                await Provider.of<ScheduleController>(context, listen: false)
                    .cancelAppointment(
                        appointmentId,
                        status == FilterStatus.Pending
                            ? 'pending'
                            : 'confirmed');
              },
            ),
          ),
        if (status == FilterStatus.Pending)
          const SizedBox(
            width: 20,
          ),
        if (status == FilterStatus.Pending)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: const Color.fromRGBO(71, 206, 254, 1)),
              child: const Text('Confirm'),
              onPressed: () async {
                await Provider.of<ScheduleController>(context, listen: false)
                    .confirmedAppointment(appointmentId);
              },
            ),
          )
      ],
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final String date;
  final String time;
  const DateTimeCard({
    Key? key,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.bg03,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                DateFormat('EEEE, MMMM d').format(DateTime.parse(date)),
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
