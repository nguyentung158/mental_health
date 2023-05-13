import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:mental_health_app/views/widgets/meditate_course_item.dart';
import 'package:provider/provider.dart';

class MeditateCourseLists extends StatelessWidget {
  final String title;
  const MeditateCourseLists({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: Provider.of<MeditateController>(context, listen: false)
                    .loadCoursesList(title),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {}
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 220,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          snapshot.data![index].addAll({'path': title});
                          return MeditateCourseItem(
                            data: snapshot.data![index],
                          );
                        },
                        itemCount: snapshot.data?.length,
                      ),
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
