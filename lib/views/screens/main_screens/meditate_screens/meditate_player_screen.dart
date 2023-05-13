import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:mental_health_app/models/meditation_ex.dart';
import 'package:mental_health_app/views/widgets/youtube_player_view.dart';
import 'package:provider/provider.dart';

class MeditatePlayerScreen extends StatefulWidget {
  final CollectionReference reference;
  final MeditationEx meditationEx;
  const MeditatePlayerScreen(
      {super.key, required this.reference, required this.meditationEx});

  @override
  State<MeditatePlayerScreen> createState() => _MeditatePlayerScreenState();
}

class _MeditatePlayerScreenState extends State<MeditatePlayerScreen> {
  @override
  void initState() {
    Provider.of<MeditateController>(context, listen: false).startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MeditateController>(context, listen: false).stopTimer();
        return true;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.meditationEx.title,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            YoutubePlayerView(
              url: widget.meditationEx.videoUrl,
            ),
            Consumer<MeditateController>(
              builder: (context, value, child) {
                return Text(
                    '${value.hour} : ${value.minute} : ${value.seconds}');
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: (() {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                animType: AnimType.bottomSlide,
                title: 'Do you want to quit meditation?',
                btnOkOnPress: () async {
                  Provider.of<MeditateController>(context, listen: false)
                      .stopTimer();
                  Navigator.of(context).pop();
                  await Provider.of<MeditateController>(context, listen: false)
                      .updateReport(widget.meditationEx.id);
                },
                btnCancelOnPress: () {},
              ).show();
            }),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  Provider.of<MeditateController>(context, listen: false)
                      .stopTimer();
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.bottomSlide,
                          title: 'Congratulation!',
                          desc: 'You had done this excisie.',
                          dismissOnTouchOutside: false,
                          btnOkOnPress: (() async {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            await Provider.of<MeditateController>(context,
                                    listen: false)
                                .doneMeditationEx(
                                    widget.reference, widget.meditationEx.id);
                          }),
                          dismissOnBackKeyPress: false)
                      .show();
                  // Provider.of<MeditateController>(context, listen: false)
                  //     .stopTimer();
                  // Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
      ),
    );
  }
}
