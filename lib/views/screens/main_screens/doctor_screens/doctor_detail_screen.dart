import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/models/doctor.dart';
import 'package:mental_health_app/theme/extention.dart';
import 'package:mental_health_app/theme/light_color.dart';
import 'package:mental_health_app/theme/text_styles.dart';
import 'package:mental_health_app/theme/theme.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/booking_appointment_screen.dart';
import 'package:mental_health_app/views/widgets/progress_widget.dart';
import 'package:mental_health_app/views/widgets/rating_star_widget.dart';
import 'package:provider/provider.dart';

class DoctorDetailScreen extends StatefulWidget {
  final DoctorModel model;
  const DoctorDetailScreen({
    super.key,
    required this.model,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DoctorDetailScreen> {
  late DoctorModel model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(
          color: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: Icon(
            model.isfavourite.contains(FirebaseAuth.instance.currentUser!.uid)
                ? Icons.favorite
                : Icons.favorite_border,
            color: model.isfavourite
                    .contains(FirebaseAuth.instance.currentUser!.uid)
                ? Colors.red
                : LightColor.grey,
          ),
          onPressed: () async {
            if (model.isfavourite
                .contains(FirebaseAuth.instance.currentUser!.uid)) {
              setState(() {
                model.isfavourite
                    .remove(FirebaseAuth.instance.currentUser!.uid);
              });
              await Provider.of<DoctorController>(context, listen: false)
                  .unfavouriteDoctor(model.uid);
            } else {
              setState(() {
                model.isfavourite.add(FirebaseAuth.instance.currentUser!.uid);
              });
              await Provider.of<DoctorController>(context, listen: false)
                  .favouriteDoctor(model.uid);
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.network(model.image),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.name,
                                style: titleStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RatingStarWidget(
                                  rating: model.rating,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            model.type,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                              value: model.goodReviews,
                              totalValue: 100,
                              activeColor: LightColor.purpleExtraLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Good Review",
                              durationTime: 500,
                            ),
                            ProgressWidget(
                              value: model.totalScore,
                              totalValue: 100,
                              activeColor: LightColor.purpleLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Total Score",
                              durationTime: 300,
                            ),
                            ProgressWidget(
                              value: model.satisfaction,
                              totalValue: 100,
                              activeColor: LightColor.purple,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Satisfaction",
                              durationTime: 800,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        Text(
                          model.description,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        BookingAppointmentScreen(
                                            docId: model.uid,
                                            subTitle: model.type,
                                            title: model.name),
                                  ));
                                },
                                child: Text(
                                  "Make an appointment",
                                  style: TextStyles.titleNormal.white,
                                ),
                              ),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
