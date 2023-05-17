import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/models/doctor.dart';
import 'package:mental_health_app/theme/extention.dart';
import 'package:mental_health_app/theme/light_color.dart';
import 'package:mental_health_app/theme/text_styles.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/doctor_detail_screen.dart';
import 'package:mental_health_app/views/widgets/search_doctors.dart';
import 'package:provider/provider.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  // late List<DoctorModel> doctorDataList;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  Widget _doctorsList(List<DoctorModel> doctorDataList, bool isLoading) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Top Doctors", style: TextStyles.title.bold),
              PopupMenuButton(
                onSelected: (selectedValues) async {
                  await Provider.of<DoctorController>(context, listen: false)
                      .filterDoctors(selectedValues);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Best Rating'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Popular'),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text('Your favourite'),
                    )
                  ];
                },
                icon: Icon(
                  Icons.sort,
                  color: Theme.of(context).primaryColor,
                ),
              )
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : getdoctorWidgetList(doctorDataList)
        ],
      ),
    );
  }

  Widget getdoctorWidgetList(List<DoctorModel> doctorDataList) {
    return Column(
        children: doctorDataList.map((x) {
      return _doctorTile(x);
    }).toList());
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: const Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                model.image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Row(
            children: [
              Text(
                '${model.rating}',
                style: TextStyles.bodySm.subTitleColor.bold,
              ),
              const Icon(
                Icons.star,
                color: LightColor.orange,
                size: 10,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                model.type,
                style: TextStyles.bodySm.subTitleColor.bold,
              ),
            ],
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(
        () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DoctorDetailScreen(model: model),
          ));
        },
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: Provider.of<DoctorController>(context, listen: false)
              .fetchAndSetData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Consumer<DoctorController>(builder: (context, value, child) {
              return CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return SearchDoctor(
                    textEditingController: textEditingController,
                  );
                }, childCount: 1)),
                _doctorsList(value.currentDoctors, value.isLoading)
              ]);
            });
          }),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Doctors',
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
    );
  }
}
