import 'package:campus/view/nav_screens/home_screen/home_screen/widgets/slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 5,
          ),
          SizedBox(),
          SliderVIew(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("News & Events"),
          ),
          
        ],
      ),
    );
  }
}
