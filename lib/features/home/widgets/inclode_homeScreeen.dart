import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/core/appRoutes.dart';
import 'package:jihagz/features/home/controllers/inclode_homeScreen.dart';
import 'package:jihagz/features/home/screens/home_widget.dart';
import 'package:jihagz/features/home/screens/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final AppCore appCore = AppCore();

  @override
  void initState() {
    super.initState();
    Get.put(InclodeHomeController());
  }

  static final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCore.backgroundColor,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appCore.surfaceColor,
        selectedItemColor: appCore.primaryColor,
        unselectedItemColor: appCore.secondaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),

      // ✅ Show FAB only when on Home tab (index 0)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                addMissingPlace();
              },
              backgroundColor: appCore.primaryColor,
              child: const Icon(Icons.add_location_alt),
              tooltip: 'Add missing place',
            )
          : null,
    );
  }
}

void addMissingPlace() {
  Get.toNamed(AppRoutes.ADD_MISSING_PLACE);
}
