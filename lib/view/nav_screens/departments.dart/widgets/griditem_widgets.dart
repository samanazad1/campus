import 'package:campus/models/model/department_model.dart';
import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.dep});
  final Department dep;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withBlue(50),
                primaryColor.withAlpha(180)
              ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dep.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
         const SizedBox()
        ],
      ),
    );
  }
}
