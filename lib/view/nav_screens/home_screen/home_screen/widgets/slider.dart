import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  const SliderView({super.key});

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  List<String> title = ["College of Engineering", "College of Engineering"];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            
            width: MediaQuery.sizeOf(context).width * .9,
            margin: const EdgeInsets.only(top: 14, right: 10, left: 5),
            height: 180,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(10)),
            child: Text(title[index]),
          );
        },
      ),
    );
  }
}
