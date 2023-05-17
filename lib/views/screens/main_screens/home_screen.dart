import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/controllers/account_controller.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/controllers/schedule_controller.dart';
import 'package:mental_health_app/data/data.dart';
import 'package:mental_health_app/models/doctor.dart';
import 'package:mental_health_app/size_config.dart';
import 'package:mental_health_app/style/app_style.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/doctors_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/schedule_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/news_screens/news_screen.dart';
import 'package:mental_health_app/views/widgets/search_medical.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
            ),
            child: Column(
              children: const [
                // User Info Area .
                UserInfo(),
                // SearchMedical Area.
                SearchMedical(),
                // Services Area .
                Services(),
                // GetBestMedicalService
                GetBestMedicalService(),
              ],
            ),
          ),
          // Upcoming Appointments
          const UpcomingAppointments()
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Provider.of<AccountController>(context, listen: false)
            .fetchAndSetAccount(),
        builder: (context, snapshot) {
          return Consumer<AccountController>(
            builder: (context, value, child) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: Text("👋 Hello!"),
              ),
              subtitle: Text(
                snapshot.connectionState == ConnectionState.waiting
                    ? "Shahin Alam"
                    : value.userInfo!.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              trailing: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  image: snapshot.connectionState == ConnectionState.waiting
                      ? const DecorationImage(
                          image: AssetImage(AppStyle.profile),
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.repeat,
                        )
                      : DecorationImage(
                          image: NetworkImage(value.userInfo!.profilePhoto),
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.repeat,
                        ),
                  borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppStyle.primarySwatch,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Services",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: servicesList
              .map(
                (e) => CupertinoButton(
                  onPressed: () {
                    if (e.title == 'Doctor') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DoctorsScreen(),
                      ));
                    } else if (e.title == 'News') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NewsScreen(),
                      ));
                    } else {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => DoctorDetailScreen(
                      //       model: doctorMapList
                      //           .map((x) => DoctorModel.fromJson(x))
                      //           .toList()[0]),
                      // ));
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal! * 17,
                    height: SizeConfig.blockSizeHorizontal! * 17,
                    decoration: BoxDecoration(
                      color: e.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: SvgPicture.asset(e.image),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class GetBestMedicalService extends StatelessWidget {
  const GetBestMedicalService({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 3),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffDCEDF9),
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal! * 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get the Best\nMental Health Service",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                        Text(
                          "Your happiness \nis our happiness",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    fontSize: 11.0,
                                    height: 1.5,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
                    child: Image.asset(AppStyle.image1),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 7,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Appointments",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScheduleScreen(),
                )),
                child: Text(
                  "See all",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2),
        FutureBuilder<void>(
            future: Provider.of<ScheduleController>(context, listen: false)
                .fetchAndSetData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<ScheduleController>(
                builder: (context, value, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Row(
                      children: value.upcomingAppointments
                          .map(
                            (e) => CupertinoButton(
                              onPressed: () async {
                                // await Provider.of<ScheduleController>(context,
                                //         listen: false)
                                //     .bookAppointment();
                              },
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                height: SizeConfig.blockSizeVertical! * 17,
                                width: SizeConfig.blockSizeHorizontal! * 80,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1C6BA4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    FutureBuilder<DoctorModel>(
                                        future: Provider.of<DoctorController>(
                                                context,
                                                listen: false)
                                            .getDoctorInfo(e.docId!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return Container(
                                            margin: const EdgeInsets.all(20),
                                            width: 71.46,
                                            height: 99.03,
                                            decoration: BoxDecoration(
                                              color: Colors.white12,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(26.0),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!
                                                    .image), // Replace with your image path
                                                fit: BoxFit
                                                    .cover, // Set the image fit mode
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [],
                                            ),
                                          );
                                        }),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          e.time!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                letterSpacing: 1,
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          e.title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                height: 1.8,
                                                letterSpacing: 1,
                                              ),
                                        ),
                                        Text(
                                          DateFormat('EEEE, MMMM d')
                                              .format(DateTime.parse(e.date!)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                letterSpacing: 1,
                                                height: 1.8,
                                                color: Colors.white60,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
