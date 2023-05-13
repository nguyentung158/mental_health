import 'dart:math';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:provider/provider.dart';

class MeditateReportScreen extends StatefulWidget {
  const MeditateReportScreen({super.key});

  @override
  State<MeditateReportScreen> createState() => _MeditateReportScreenState();
}

class _MeditateReportScreenState extends State<MeditateReportScreen> {
  List<DateTime> val = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Report',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: Provider.of<MeditateController>(context, listen: false)
              .loadReport(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List data = snapshot.data!['history'] as List;
            val.clear();
            for (var element in data) {
              val.add(DateTime.parse(element));
            }
            return Column(
              children: [
                const Text('History'),
                CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      selectableDayPredicate: (day) => false,
                      calendarType: CalendarDatePicker2Type.multi,
                    ),
                    value: val),
                const Divider(),
                Expanded(
                  child: GridView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data!['time'] ~/ 60}m',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'time spent',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data!['sessions'].length}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'sessions learned',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12,
                        ),
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${val.length}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'days spent',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
