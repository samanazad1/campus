import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:campus/view/z_general_widget/%20drawer.dart';
import 'package:campus/view/nav_screens/home_screen/departments.dart/departments_screen.dart';
import 'package:campus/view/nav_screens/home_screen/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final _pages = const [HomePage(), DepartmentsScreen(), Text("")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: index == 0 ? const MyDrawer() : null,
      appBar: AppBar(
        title: index == 0
            ? Text(
                "Home",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            : index == 1
                ? Text(
                    "Departments",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                : Text(
                    "No",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
        backgroundColor: primaryColor,
        elevation: 3,
      ),
      body: IndexedStack(index: index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 12.5,
        currentIndex: index,
        onTap: (ind) {
          setState(() {
            index = ind;
          });
        },
        backgroundColor: Colors.brown[50],
        selectedItemColor: primaryColor.withAlpha(180),
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.category), label: 'Departments'),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.arrow_down), label: 's'),
        ],
      ),
    );
  }
}
