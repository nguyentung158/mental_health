import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_app/controllers/doctor_controller.dart';
import 'package:mental_health_app/size_config.dart';
import 'package:mental_health_app/style/app_style.dart';
import 'package:provider/provider.dart';

class SearchDoctor extends StatelessWidget {
  final TextEditingController textEditingController;

  const SearchDoctor({super.key, required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical! * 3, horizontal: 16),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) =>
            Provider.of<DoctorController>(context, listen: false)
                .searchDoctor(textEditingController.text),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: CupertinoButton(
            onPressed: () {},
            child: SvgPicture.asset(AppStyle.searchIcon),
          ),
          hintText: "Search doctors..",
          fillColor: AppStyle.inputFillColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
