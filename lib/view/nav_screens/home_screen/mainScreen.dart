import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:campus/view/z_general_widget/%20drawer.dart';
import 'package:campus/view/nav_screens/home_screen/departments.dart/departments_screen.dart';
import 'package:campus/view/nav_screens/home_screen/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final _pages = const [HomePage(), DepartmentsScreen(), Text("")];
  final List<Widget> titles = const [
    Text(
      "College of Engineering",
      style: TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    Text(
      "Department",
      style: TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    Text(
      "Transactions",
      style: TextStyle(
          fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: index == 0 ? const MyDrawer() : null,
      appBar: AppBar(
        title: IndexedStack(
          alignment: Alignment.center,
          index: index,
          children: titles,
        ),
        backgroundColor: primaryColor,
        elevation: 3,
      ),
      body: IndexedStack(index: index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        selectedItemColor: primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(IconlyBold.category), label: "Department"),
          BottomNavigationBarItem(icon: Icon(IconlyBold.paper), label: "Transactions")
        ],
      ),
    );
  }
}
