import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: size.height * .35,
          ),
          const Text(
            "Choose a languge below",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height * .03,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'English',
              )),
          SizedBox(
            height: size.height * .015,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Kurdish',
              )),
          SizedBox(
            height: size.height * .015,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Arabic',
              ))
        ]),
      ),
    );
  }
}
