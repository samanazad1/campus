
import 'package:campus/view/nav_screens/home_screen/home_screen/widgets/coursel.dart';
import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:campus/view/z_general_widget/animate_smooth.dart';
import 'package:campus/view/z_general_widget/carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

class SliderVIew extends StatefulWidget {
  const SliderVIew({Key? key}) : super(key: key);

  @override
  State<SliderVIew> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<SliderVIew> {
  int index = 0;

  double dotSize = 7.0;
  Color dotColor = Colors.grey[400]!;

  

  @override
  Widget build(BuildContext context) {
    List<String> images=[
      'assets/images/college.jpeg',
      'assets/images/college.jpeg',
      
    ];
    
    return Column(
          children: [
                CarouselSlider.builder(
                    itemCount:images.length ,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(images[index])),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: .999,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      onPageChanged: (val, _) {
                        setState(() {
                          index = val;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSmoothIndicator(
              activeIndex: index,
              count:images.length,
              effect: WormEffect(
                activeDotColor: primaryColor,
                dotWidth: 7,
                dotHeight: 7,
                dotColor: Colors.grey[400]!,
              ),
            ),
          ],
        );
      
  }
}
