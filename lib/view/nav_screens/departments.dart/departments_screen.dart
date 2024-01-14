import 'package:campus/models/data/department_data.dart';
import 'package:campus/view/nav_screens/departments.dart/widgets/griditem_widgets.dart';
import 'package:flutter/material.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: availableDeps.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 150),
        itemBuilder: (context, index) {
          final item = availableDeps[index];
          return GridItem(dep: item);
        },
      ),
    );
  }
}
